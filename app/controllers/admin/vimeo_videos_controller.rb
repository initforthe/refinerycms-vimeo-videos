module Admin
  class VimeoVideosController < Admin::BaseController
    
    include ::Refinery::VimeoVideos::Account
    
    before_filter :init_dialog
    
    def index
      if authorized?
        get_videos_on_vimeo_account
      elsif request.xhr?
        render :text => 'You have not authorized this application to use your vimeo account.'
      else
        raise ArgumentError, 'You have not authorized this application to use your vimeo account.'
      end
    end
    
    def new
      @vimeo_video = VimeoVideo.new
    end
    
    def create
      
    end
    
    def insert
      self.new if @vimeo_video.nil?

      @url_override = admin_vimeo_videos_url(:dialog => from_dialog?, :insert => true)

      if params[:conditions].present?
        extra_condition = params[:conditions].split(',')

        extra_condition[1] = true if extra_condition[1] == "true"
        extra_condition[1] = false if extra_condition[1] == "false"
        extra_condition[1] = nil if extra_condition[1] == "nil"
        paginate_vimeo_videos({extra_condition[0].to_sym => extra_condition[1]})
      else
        paginate_vimeo_videos
      end
      render :action => "insert"
    end
    
    protected
      def get_videos_on_vimeo_account
        video = Vimeo::Advanced::Video.new(
          account[:consumer_key],
          account[:consumer_secret],
          :token => account[:token],
          :secret => account[:secret])
        @vimeo_videos = video.get_all(account[:username], {:full_response => true, :sort => 'upload_date'})["videos"]["video"]
      end
      
      def init_dialog
        @app_dialog = params[:app_dialog].present?
        @field = params[:field]
        @update_vimeo_video = params[:update_vimeo_video]
        @update_text = params[:update_text]
        @thumbnail = params[:thumbnail]
        @callback = params[:callback]
        @conditions = params[:conditions]
        @current_link = params[:current_link]
      end

      def restrict_controller
        super unless action_name == 'insert'
      end

      def paginate_vimeo_videos(conditions={})
        @vimeo_videos = get_videos_on_vimeo_account.paginate   :page => (@paginate_page_number ||= params[:page]),
                                         :conditions => conditions,
                                         :order => 'created_at DESC',
                                         :per_page => VimeoVideo.per_page(from_dialog?)
      end
  end
end