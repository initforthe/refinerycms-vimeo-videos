require 'refinerycms-base'
require 'vimeo'
require 'refinerycms-vimeo-videos/version'

module Refinery
  module VimeoVideos
    
    autoload :URLTempfile,            'refinerycms-vimeo-videos/url_tempfile.rb'
    autoload :Account,                'refinerycms-vimeo-videos/account.rb'
    autoload :ActiveRecordExtension,  'refinerycms-vimeo-videos/active_record_extension.rb'
    
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      initializer "add active record extensions" do |app|
        ActiveRecord::Base.class_eval { include Refinery::VimeoVideos::ActiveRecordExtension }
      end
      
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.version = Refinery::VimeoVideos::VERSION
          plugin.name = "vimeo_videos"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end