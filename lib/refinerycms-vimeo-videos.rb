require 'vimeo'
require 'will_paginate/array'
require File.expand_path('../refinery/vimeo-videos/version', __FILE__)
require File.expand_path('../generators/vimeo_videos_generator', __FILE__)

module Refinery
  module VimeoVideos
    
    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end
    
    autoload :URLTempfile,            File.expand_path('../refinery/vimeo-videos/url_tempfile', __FILE__)
    autoload :Account,                File.expand_path('../refinery/vimeo-videos/account', __FILE__)
    
    class Engine < Rails::Engine
      initializer "init plugin", :after => :set_routes_reloader do |app|
        ::Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.version = ::Refinery::VimeoVideos::VERSION
          plugin.name = "vimeo_videos"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end

require File.expand_path('../refinery/vimeo-videos/active_record', __FILE__)

module ActiveRecord
  class Base
    extend ::Refinery::VimeoVideos::ActiveRecord
  end
end

::Refinery.engines << 'vimeo_videos'