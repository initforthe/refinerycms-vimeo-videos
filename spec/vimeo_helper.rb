require 'fakeweb'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def vimeo_base_url(url = "/")
  "http://vimeo.com#{url}"
end

def vimeo_url(url = "")
  vimeo_base_url("/api/v2#{url}")
end

def advanced_vimeo_url(url = "")
  vimeo_base_url("/api/rest/v2#{url}")
end

def stub_get(url, filename, status=nil)
  # FIXME: We have to specify content type, otherwise HTTParty will not parse the 
  # body correctly. Is there any way we can get around this? Or is this a limitation
  # of using FakeWeb?
  options = { :body => fixture_file(filename), :content_type => 'application/json' }
  options.merge!({:status => status}) unless status.nil?
  FakeWeb.register_uri(:get, vimeo_url(url), options)
end

def stub_post(url, filename)
  FakeWeb.register_uri(:post, advanced_vimeo_url, :body => fixture_file(filename), :content_type => 'application/json')
end

def stub_custom_get(url, filename)
  FakeWeb.register_uri(:get, vimeo_base_url(url), :body => fixture_file(filename), :content_type => 'application/json')
end

def stub_custom_post(url, filename)
  FakeWeb.register_uri(:post, vimeo_base_url(url), :body => fixture_file(filename), :content_type => 'application/json')
end

def stub_vimeo_embed_uri(geometry)
  geometry_hash = VimeoEmbedCache.geometry_hash(geometry)
  
  FakeWeb.register_uri( :get,
                        "http://vimeo.com/api/oembed.xml?url=http%3A%2F%2Fvimeo.com%2F123456&#{geometry_hash.to_query}",
                        :body => fixture_file("oembed/oembed.json"),
                        :content_type => 'application/json' )
end