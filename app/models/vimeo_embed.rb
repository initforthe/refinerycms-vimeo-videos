require 'httparty'

class VimeoEmbed < ActiveRecord::Base
  
  belongs_to :vimeo_video
    
  before_save :update_embed_code
  
  serialize :configuration, Hash
    
  validates_presence_of :configuration
  validates_presence_of :vid
  
  def self.embed vid, geometry, configuration = {}
    configuration.stringify_keys!
    configuration.merge!(geometry_hash(geometry))
        
    static = configuration.delete("static") if configuration.has_key?("static")
    if static
      geometry =~ FIXED_GEOMETRY ?
        static_embed_code(vid, geometry) : raise(ArgumentError, "Must use fixed geometry string for static embeds (e.g. 100x240)")
    else
      find_or_create_by_vid_and_configuration(vid, :configuration => YAML.dump(configuration))
    end
  end
  
  FIXED_WIDTH_GEOMETRY    = /^(\d+)$/ # e.g. '300'
  FIXED_HEIGHT_GEOMETRY   = /^x(\d+)$/ # e.g. 'x200'
  FIXED_GEOMETRY          = /^(\d+)x(\d+)$/ # e.g. '300x200'
  VIMEO_GEOMETRY = Regexp.union FIXED_GEOMETRY, FIXED_HEIGHT_GEOMETRY, FIXED_WIDTH_GEOMETRY
  
  def self.geometry_hash geometry
    case geometry
    when FIXED_WIDTH_GEOMETRY
      {:width => $1}
    when FIXED_HEIGHT_GEOMETRY
      {:height => $1}
    when FIXED_GEOMETRY
      {:width => $1, :height => $2}
    else raise ArgumentError, "Didn't recognise the geometry string #{self.geometry}"
    end
  end
    
  private
    
    def self.static_embed_code vid, geometry
      width, height = geometry.split('x')
      "<iframe src=\"http://player.vimeo.com/video/#{vid}?portrait=0\" width=\"#{width}\" height=\"#{height}\" frameborder=\"0\"></iframe>"
    end
  
    def update_embed_code force = false
      if self.code.blank? or force  
        # Escape vimeo url and request oembed code
        url = CGI::escape("http://vimeo.com/#{self.vid}")
        
        response = HTTParty.get "http://vimeo.com/api/oembed.xml?url=#{url}&#{self.configuration.to_query}"
        self.code = response["oembed"]["html"]
      end
    end
end