class VimeoVideo < ActiveRecord::Base
  
  belongs_to :attachable, :polymorphic => true

  acts_as_indexed :fields => [:title, :vimeo_video_uid, :vimeo_video_name]

  #validates :title, :presence => true, :uniqueness => true
  
  def embed_code geometry
    width, height = gemotry.split('x')
    "<iframe src=\"http://player.vimeo.com/video/#{self.vimeo_video_uid}?portrait=0\" width=\"#{width}\" height=\"#{height}\" frameborder=\"0\"></iframe>"
  end
  
  # when a dialog pops up with vimeo_videos, how many vimeo_videos per page should there be
  PAGES_PER_DIALOG = 32

  # when listing vimeo_videos out in the admin area, how many vimeo_videos should show per page
  PAGES_PER_ADMIN_INDEX = 20

  class << self
    # How many vimeo_videos per page should be displayed?
    def per_page(dialog = false, has_size_options = false)
      if dialog
        PAGES_PER_DIALOG
      else
        PAGES_PER_ADMIN_INDEX
      end
    end
  end
  
end
