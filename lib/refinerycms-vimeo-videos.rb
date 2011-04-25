require 'refinerycms-base'
require 'vimeo'

require 'refinerycms_vimeo_videos/account'
require 'refinerycms_vimeo_videos/active_record_extension'
require 'refinerycms_vimeo_videos/url_tempfile'

module Refinery
  module VimeoVideos
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
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
