module Refinery
  module VimeoVideos
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::VimeoVideos
      engine_name :refinery_vimeo_videos
      
      initializer "register refinerycms_vimeo_videos plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_vimeo_videos"
          plugin.version = ::Refinery::VimeoVideos::VERSION
          plugin.hide_from_menu = true
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::VimeoVideos)
      end
    end
  end
end

require File.expand_path('../active_record', __FILE__)

module ActiveRecord
  class Base
    extend ::Refinery::VimeoVideos::ActiveRecord
  end
end