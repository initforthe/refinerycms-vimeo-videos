require 'vimeo'
require 'refinerycms-vimeo-videos/version'

module Refinery
  module VimeoVideos
    
    autoload :URLTempfile,            'refinerycms-vimeo-videos/url_tempfile.rb'
    autoload :Account,                'refinerycms-vimeo-videos/account.rb'
    
    class Engine < Rails::Engine
      initializer 'vimeo_videos.serve_static_assets' do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
            
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.version = Refinery::VimeoVideos::VERSION
          plugin.name = "vimeo_videos"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end

require 'refinerycms-vimeo-videos/active_record.rb'

module ActiveRecord
  class Base
    extend ::Refinery::VimeoVideos::ActiveRecord
  end
end