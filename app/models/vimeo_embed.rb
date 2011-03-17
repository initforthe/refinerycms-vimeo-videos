class VimeoEmbed < ActiveRecord::Base
  
  belongs_to :vimeo_video
  
  serialize :options
  
  before_save :update_embed_code
  
  validates_presence_of :options
  validates_presence_of :vimeo_id
  validates_presence_of :code
  
  def self.embed vimeo_id, geometry, options = {}
    options.stringify_keys!
    
    static = options.delete["static"] if options.has_key("static")
    if static
      geometry =~ FIXED_GEOMETRY ?
        static_embed_code geometry : raise VideoEmbed::Error
    else
      VideoEmbed.find_or_create_by_vimeo_id_and_geometry_and_options(vimeo_id, geometry, options)
    end
    
    rescue VideoEmbed::Error => exception
      flash[:error] = "Not a fixed geometry for static embed - e.g. '100x100': #{exception.message}"
  end
  
  private
    
    def self.static_embed_code geometry
      width, height = geometry.split('x')
      "<iframe src=\"http://player.vimeo.com/video/#{self.vimeo_video_uid}?portrait=0\" width=\"#{width}\" height=\"#{height}\" frameborder=\"0\"></iframe>"
    end
  
    def update_embed_code force = false
      if self.code.blank? or force
        
        # Merge geometry and options
        self.options.merge!(self.geometry_hash)
      
        # Escape vimeo url and request oembed code
        url = CGI::escape("http://vimeo.com/#{self.vimeo_id}?#{self.options.to_query}")
        response = HTTParty.get "http://vimeo.com/api/oembed.xml?url=#{url}"
      
        self.code = response["oembed"]["html"]
      
      end
    end
    
    FIXED_WIDTH_GEOMETRY    = /^\d+$/ # e.g. '300'
    FIXED_HEIGHT_GEOMETRY   = /^x\d+$/ # e.g. 'x200'
    FIXED_GEOMETRY          = /^\d+x\d+$/ # e.g. '300x200'
    VIMEO_GEOMETRY = Regexp.union FIXED_GEOMETRY, FIXED_HEIGHT_GEOMETRY, FIXED_WIDTH_GEOMETRY
    
    def geometry_hash
      case self.geometry
      when FIXED_WIDTH_GEOMETRY
        {:width => $1}
      when FIXED_HEIGHT_GEOMETRY
        {:height => $1}
      when FIXED_GEOMETRY
        {:width => $1, :height => $2}
      else raise ArgumentError, "Didn't recognise the geometry string #{self.geometry}"
      end
    end
end

module VimeoEmbed; class Error < StandardError; end; end