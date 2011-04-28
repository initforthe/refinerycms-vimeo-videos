module Refinery
  module VimeoVideos
    module Account
    
      # This will extend controllers and models to centralize account setup logic
    
      protected
      
        CONSUMER_KEY_FORMAT = /^\w{32}$/
        CONSUMER_SECRET_FORMAT = /^\w{16}$/
        TOKEN_FORMAT = /^\w{32}$/
        SECRET_FORMAT = /^\w{40}$/
    
        def ready_to_authorize?
          account[:consumer_key] =~ CONSUMER_KEY_FORMAT and account[:consumer_secret] =~ CONSUMER_SECRET_FORMAT
        end

        def authorized?
          account[:token] =~ TOKEN_FORMAT and account[:secret] =~ SECRET_FORMAT
        end
    
        def account
          @account ||= {
            :username => RefinerySetting.find_or_set(:vimeo_username, :value => "Username"),
            :consumer_key => RefinerySetting.find_or_set(:vimeo_consumer_key, :value => "Consumer Key"),
            :consumer_secret => RefinerySetting.find_or_set(:vimeo_consumer_secret, :value => "Consumer Secret"),
            :token => RefinerySetting.find_or_set(:vimeo_token, :value => 'Token'),
            :secret => RefinerySetting.find_or_set(:vimeo_secret, :value => 'Secret')}
        end
      
    end
  end
end