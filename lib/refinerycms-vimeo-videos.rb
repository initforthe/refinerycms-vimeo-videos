require 'vimeo'
require 'refinery/vimeo-videos/version'

module ::Refinery
  module VimeoVideos
    
    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end
    
    autoload :URLTempfile,            'refinery/vimeo-videos/url_tempfile.rb'
    autoload :Account,                'refinery/vimeo-videos/account.rb'
    
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

require 'refinery/vimeo-videos/active_record.rb'

module ActiveRecord
  class Base
    extend ::Refinery::VimeoVideos::ActiveRecord
  end
end

::Refinery.engines << 'vimeo_videos'