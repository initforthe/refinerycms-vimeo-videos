require 'vimeo'
class VimeoMetaCache < ActiveRecord::Base
  
  set_table_name "vimeo_meta_cache"
  
  has_many :vimeo_video_embed_caches, :dependent => :destroy
  
  belongs_to :image, :class_name => 'Image'
  
  before_save :cache
  
  validates_presence_of :vid
  
  def embed geometry, options = {}
    VimeoEmbedCache.embed(self.vid, geometry, options).code
  end
  
  def url
    "http://www.vimeo.com/#{self.vid}"
  end
  
  def force_cache
    cache true
    self.save
  end
  
  private
    
    def cache force = false
      if self.title.blank? or self.image_id.blank?
        get_account
        video = Vimeo::Advanced::Video.new(
          @account[:consumer_key],
          @account[:consumer_secret],
          :token => @account[:token],
          :secret => @account[:secret])
        video_info = video.get_info(self.vid)["video"].first
        
        # Save cached image
        vimeo_thumb_url = video_info["thumbnails"]["thumbnail"].last["_content"]
        self.create_image(:image => URLTempfile.new(vimeo_thumb_url)) if self.image_id.blank? or force
        
        # Save cached title
        self.title = video_info["description"] if self.title.blank? or force
      end
    end
    
    def get_account
      @account = {
        :username => RefinerySetting.find_or_set('vimeo_username', :value => "Username"),
        :consumer_key => RefinerySetting.find_by_name('vimeo_consumer_key').value,
        :consumer_secret => RefinerySetting.find_by_name('vimeo_consumer_secret').value,
        :token => RefinerySetting.find_by_name('vimeo_token').value,
        :secret => RefinerySetting.find_by_name('vimeo_secret').value}
    end
end