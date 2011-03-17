module NavigationHelpers
  module Moxie
    module VimeoVideos
      def path_to(page_name)
        case page_name
        when /the list of vimeo_videos/
          admin_vimeo_videos_path

         when /the new vimeo_video form/
          new_admin_vimeo_video_path
        else
          nil
        end
      end
    end
  end
end
