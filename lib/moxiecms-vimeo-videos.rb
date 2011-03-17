require 'moxie'

module Moxie
  module VimeoVideos
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      # Make sure these settings exist
      initializer "account settings" do |app|
        MoxieSetting.find_or_set('vimeo_consumer_key', :value => "Consumer Key")
        MoxieSetting.find_or_set('vimeo_consumer_secret', :value => "Consumer Secret")
        MoxieSetting.find_or_set('vimeo_token', :value => "Token")
        MoxieSetting.find_or_set('vimeo_secret', :value => "Secret")
        MoxieSetting.find_or_set('vimeo_username', :value => "Username")
      end

      config.after_initialize do
        Moxie::Plugin.register do |plugin|
          plugin.name = "vimeo_videos"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end
