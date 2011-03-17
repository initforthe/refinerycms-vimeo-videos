class VimeoVideo < ActiveRecord::Base
  
  belongs_to :attachable, :polymorphic => true
  has_many :vimeo_video_embeds, :dependant => :destroy
  
  def embed geometry, options = {}
    VimeoEmbed.embed self.vimeo_id, geometry, options
  end
end