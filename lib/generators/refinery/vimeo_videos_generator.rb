module Refinery
  class VimeoVideosGenerator < Rails::Generators::Base
    def rake_db
      rake "refinery_vimeo_videos:install:migrations"
    end
    
    source_root File.expand_path('../templates', __FILE__)
    
    def generate_vimeo_videos_initializer
      template "config/initializers/refinery_vimeo_videos.rb.erb", File.join(destination_root, "config", "initializers", "refinery_vimeo_videos.rb")
    end
  end
end