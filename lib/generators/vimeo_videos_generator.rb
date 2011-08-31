require 'refinery/generators'

module Refinery
  class VimeoVideosGenerator < ::Refinery::Generators::EngineInstaller

    source_root File.expand_path('../../../', __FILE__)
    engine_name "vimeo_videos"

  end
end