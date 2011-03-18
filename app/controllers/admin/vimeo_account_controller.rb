module Admin
  class VimeoAccountController < Admin::BaseController
    
    CONSUMER_KEY_FORMAT = /[a-z0-9]{32}/
    CONSUMER_SECRET_FORMAT = /[a-z0-9]{16}/
    TOKEN_FORMAT = /[a-z0-9]{32}/
    SECRET_FORMAT = /[a-z0-9]{40}/
    
    def authorization
      unless authorized?
        base = Vimeo::Advanced::Base.new(
          account[:vimeo_consumer_key],
          account[:vimeo_consumer_secret])
        request_token = base.get_request_token
        session[:oauth_secret] = request_token.secret
        redirect_to base.authorize_url
      elsif ready_to_authorize?
        vimeo_callback
      else
        render :text => 'Not ready to authorize. Type in consumer_key and consumer_secret.'
      end
    end
  
    def callback
      base = Vimeo::Advanced::Base.new(
        account[:vimeo_consumer_key],
        account[:vimeo_consumer_secret])
      access_token = base.get_access_token(params[:oauth_token], session[:oauth_secret], params[:oauth_verifier])
      account[:vimeo_token].update_attribute(:value, access_token.token)
      account[:vimeo_secret].update_attribute(:value, access_token.secret)
      flash[:notice] = "You successfully authorized your vimeo account for integration in your backend. You can now start using it."
      redirect_to '/admin'
    end
    
    private
      
      def ready_to_authorize?
        return account[:vimeo_consumer_key] =~ CONSUMER_KEY_FORMAT and account[:vimeo_consumer_secret] =~ CONSUMER_SECRET_FORMAT
      end
    
      def authorized?
        return account[:vimeo_token] =~ TOKEN_FORMAT and account[:vimeo_secret] =~ SECRET_FORMAT
      end
      
      def get_account
        account = {
          :vimeo_consumer_key => MoxieSetting.find_by_name('vimeo_consumer_key').value,
          :vimeo_consumer_secret => MoxieSetting.find_by_name('vimeo_consumer_secret').value,
          :vimeo_token => MoxieSetting.find_by_name('vimeo_token').value,
          :vimeo_secret => MoxieSetting.find_by_name('vimeo_secret').value}
      end

  end
end
