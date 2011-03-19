module Admin
  class VimeoVideosController < Admin::VimeoBaseController
    
    def index
      if authorized?
        get_videos_on_vimeo_account
      elsif request.xhr?
        render :text => 'You are have not authorized this app to use your vimeo account.'
      else
        raise ArgumentError, 'You are have not authorized this app to use your vimeo account.'
      end
    end
    
    protected
      def get_videos_on_vimeo_account
        get_account
        video = Vimeo::Advanced::Video.new(
          @account[:consumer_key],
          @account[:consumer_secret],
          :token => @account[:token],
          :secret => @account[:secret])
        @vimeo_videos = video.get_all(@account[:username], {:full_response => true, :sort => 'upload_date'})["videos"]["video"]
      end
  end
end