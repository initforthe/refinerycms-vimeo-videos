class VimeoVideo < ActiveRecord::Base
  
  belongs_to :attachable, :polymorphic => true
  has_many :vimeo_video_embeds, :dependent => :destroy
  
  def embed geometry, options = {}
    VimeoEmbed.embed self.vid, geometry, options
  end
end