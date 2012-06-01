require 'refinerycms-core'
require 'vimeo'
require 'will_paginate/array'
require File.expand_path('../vimeo-videos/version', __FILE__)

module Refinery
  autoload :VimeoVideosGenerator, 'generators/refinery/vimeo_videos_generator'
  
  module VimeoVideos
    require 'refinery/vimeo-videos/engine'
    require 'refinery/vimeo-videos/configuration'
    
    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end

      def table_name_prefix
        'refinery_vimeo_'
      end
    end
        
    autoload :URLTempfile, 'refinery/vimeo-videos/url_tempfile'
  end
end