class VimeoMetaCache < ActiveRecord::Base
  
  extend ::RefinerycmsVimeoVideos::Account
  
  set_table_name "vimeo_meta_cache"
  
  has_many :vimeo_embed_caches, :dependent => :destroy
  
  belongs_to :image, :class_name => 'Image'
  
  before_save :cache
  
  validates_presence_of :vid
  
  def embed geometry, options = {}
    VimeoEmbedCache.embed(self.vid, geometry, options).code
  end
  
  def url
    "http://www.vimeo.com/#{self.vid}"
  end
  
  def update_cache image = false
    cache true, images
    self.save
  end
  
  private
    
    def cache force = false, images = false
      if self.title.blank? or self.image_id.blank? or self.description.blank?
        
        video = Vimeo::Advanced::Video.new(
          account[:consumer_key],
          account[:consumer_secret],
          :token => account[:token],
          :secret => account[:secret])
        video_info = video.get_info(self.vid)["video"].first
        
        # By default omitt image if we already have one.
        # If we force an update, we need to specifically force images as well by
        # calling this method with force and images true.
        
        if (images and force) or not image_id?
          # Save fetched image url
          vimeo_thumb_url = video_info["thumbnails"]["thumbnail"].last["_content"]
          self.create_image(:image => URLTempfile.new(vimeo_thumb_url))
        end
        
        # Save fetched title
        self.title = video_info["title"] if self.title.blank? or force
        
        # Save fetched description
        self.description = video_info["description"] if self.description.blank? or force
      end
    end
    
end