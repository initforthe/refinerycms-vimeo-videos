module Refinery
  class VimeoMetaCache < ActiveRecord::Base
      
    set_table_name "refinery_vimeo_meta_cache"
  
    has_many :vimeo_embed_caches, :dependent => :destroy
  
    belongs_to :image, :class_name => '::Refinery::Image'
  
    before_save :cache
  
    validates_presence_of :vid
  
    def embed geometry, options = {}
      ::Refinery::VimeoEmbedCache.embed(self.vid, geometry, options)
    end
  
    def url
      "http://www.vimeo.com/#{self.vid}"
    end
  
    def update_cache images = false
      cache true, images
      self.save
    end
  
    private
    
      def cache force = false, images = false
        if !self.title? or !self.image_id? or !self.description? or force
                  
          video_info = Vimeo::Simple::Video.info(self.vid).first
        
          # By default omitt image if we already have one.
          # If we force an update, we need to specifically force images as well by
          # calling this method with force and images true.
        
          if images or !image_id?
            # Save fetched image url
            vimeo_thumb_url = video_info["thumbnail_large"]
            self.create_image(:image => ::Refinery::VimeoVideos::URLTempfile.new(vimeo_thumb_url))
          end
        
          # Save fetched title
          self.title = video_info["title"] if !self.title? or force
        
          # Save fetched description
          self.description = "<p>#{video_info['description']}</p>" if !self.description? or force
        end
      end
    
  end
end