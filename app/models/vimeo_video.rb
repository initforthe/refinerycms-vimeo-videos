class VimeoVideo < ActiveRecord::Base
  
  belongs_to :attachable, :polymorphic => true

  acts_as_indexed :fields => [:title, :vimeo_video_uid, :vimeo_video_name]
    
  def embed_code geometry
    width, height = geometry.split('x')
    "<iframe src=\"http://player.vimeo.com/video/#{self.vimeo_video_uid}?portrait=0\" width=\"#{width}\" height=\"#{height}\" frameborder=\"0\"></iframe>"
  end  
end
