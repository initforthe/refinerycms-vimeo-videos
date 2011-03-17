module Admin
  class VimeoAccountController < Admin::BaseController

    def authorization
      #unless current_admin.vimeo_authorized?
      #  base = Vimeo::Advanced::Base.new(
      #    MoxieSetting.find_or_set('vimeo_consumer_key', :value => "Consumer Key"),
      #    MoxieSetting.find_or_set('vimeo_consumer_secret', :value => "Consumer Secret"))
      #  request_token = base.get_request_token
      #  session[:oauth_secret] = request_token.secret
      #  redirect_to base.authorize_url
      #else
      #  vimeo_callback
      #end
    end
  
    def callback
      #base = Vimeo::Advanced::Base.new(
      #  MoxieSetting.find_or_set('vimeo_consumer_key', :value => "Consumer Key"),
      #  MoxieSetting.find_or_set('vimeo_consumer_secret', :value => "Consumer Secret"))
      #access_token = base.get_access_token(params[:oauth_token], session[:oauth_secret], params[:oauth_verifier])
      #MoxieSetting.find_or_set('vimeo_token', :value => access_token.token)
      #MoxieSetting.find_or_set('vimeo_secret', :value => access_token.secret)
      #flash[:notice] = "You successfully authorized your vimeo account for integration in your backend. You can now start using it."
      #redirect_to '/admin'
    end

  end
end
