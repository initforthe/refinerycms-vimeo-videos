require 'refinery'

module Refinery
  module VimeoVideos
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      # Make sure these settings exist
      initializer "account settings" do |app|
        RefinerySetting.find_or_set('vimeo_consumer_key', :value => "Consumer Key")
        RefinerySetting.find_or_set('vimeo_consumer_secret', :value => "Consumer Secret")
        RefinerySetting.find_or_set('vimeo_token', :value => "Token")
        RefinerySetting.find_or_set('vimeo_secret', :value => "Secret")
        RefinerySetting.find_or_set('vimeo_username', :value => "Username")
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "vimeo_videos"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end
