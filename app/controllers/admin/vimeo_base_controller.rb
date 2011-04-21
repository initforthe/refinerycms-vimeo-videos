require 'vimeo'
module Admin
  class VimeoBaseController < Admin::BaseController
    
    before_filter :get_account
    
    CONSUMER_KEY_FORMAT = /[a-z0-9]{32}/
    CONSUMER_SECRET_FORMAT = /[a-z0-9]{16}/
    TOKEN_FORMAT = /[a-z0-9]{32}/
    SECRET_FORMAT = /[a-z0-9]{40}/
    
    protected
      
      # Hack because I don't know how to turn off restriction otherwise
      def restrict_plugins
      end
      
      # Hack because I don't know how to turn off restriction otherwise
      def restrict_controller
      end
      
      def ready_to_authorize?
        @account[:consumer_key] =~ CONSUMER_KEY_FORMAT and @account[:consumer_secret] =~ CONSUMER_SECRET_FORMAT
      end
  
      def authorized?
        @account[:token] =~ TOKEN_FORMAT and @account[:secret] =~ SECRET_FORMAT
      end
      
      def get_account
        @account = {
          :username => RefinerySetting.find_or_set(:vimeo_username, :value => "Username"),
          :consumer_key => RefinerySetting.find_or_set(:vimeo_consumer_key, :value => "Consumer Key"),
          :consumer_secret => RefinerySetting.find_or_set(:vimeo_consumer_secret, :value => "Consumer Secret"),
          :token => RefinerySetting.find_or_set(:vimeo_token, :value => 'Token'),
          :secret => RefinerySetting.find_or_set(:vimeo_secret, :value => 'Secret')}
      end

  end
end