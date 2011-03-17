module Admin
  class VimeoVideosController < Admin::BaseController
    
    def index
      get_videos_on_vimeo_account
    end
    
    protected
    
      def get_videos_on_vimeo_account
        video = Vimeo::Advanced::Video.new(
          MoxieSetting.find_or_set('vimeo_consumer_key', :value => "Consumer Key"),
          MoxieSetting.find_or_set('vimeo_consumer_secret', :value => "Consumer Secret"),
          :token => MoxieSetting.find_or_set('vimeo_token', :value => "Token"),
          :secret => MoxieSetting.find_or_set('vimeo_secret', :value => "Secret"))
        @vimeo_videos = video.get_all(MoxieSetting.find_or_set('vimeo_username', :value => "Username"), {:full_response => true, :sort => 'upload_date'})["videos"]["video"]
      end    
  end
end