module Admin
  class VimeoAccountController < VimeoBaseController
    
    def authorization
      if not authorized? and ready_to_authorize?
        base = Vimeo::Advanced::Base.new(
          @account[:consumer_key],
          @account[:consumer_secret])
        request_token = base.get_request_token
        session[:oauth_secret] = request_token.secret
        redirect_to base.authorize_url
      elsif ready_to_authorize?
        callback
      else
        raise ArgumentError, 'Not ready to authorize. Type in consumer_key and consumer_secret.'
      end
    end
  
    def callback
      base = Vimeo::Advanced::Base.new(
        @account[:consumer_key],
        @account[:consumer_secret])
      access_token = base.get_access_token(params[:oauth_token], session[:oauth_secret], params[:oauth_verifier])
      RefinerySetting.find_by_name('vimeo_token').update_attribute(:value, access_token.token)
      RefinerySetting.find_by_name('vimeo_secret').update_attribute(:value, access_token.secret)
      flash[:notice] = "You successfully authorized your vimeo account for integration in your backend. You can now start using it."
      redirect_to '/admin'
    end

  end
end
