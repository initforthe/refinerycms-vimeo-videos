require 'spec_helper'
require File.expand_path '../../vimeo_helper', __FILE__

describe VimeoEmbedCache do

  def reset_vimeo_embed_cache(options = {})
    stub_vimeo_embed_uri '100x300'
    
    @valid_attributes = {
      :geometry => '100x300',
      :vid => 123456
    }

    @vimeo_embed_cache.destroy! if @vimeo_embed_cache
    @vimeo_embed_cache = VimeoEmbedCache.embed(@valid_attributes[:vid], @valid_attributes[:geometry])
  end

  before(:each) do
    FakeWeb.clean_registry
    reset_vimeo_embed_cache
  end

  context "validations" do
    
    it "shouldn't work if only vid given" do
      lambda { VimeoEmbedCache.embed(@valid_attributes[:vid]) }.should raise_error ArgumentError
    end
    
    it "should allow static embedding only if width and height given" do
      VimeoEmbedCache.embed(@valid_attributes[:vid], @valid_attributes[:geometry], :static => true).should_not == @vimeo_embed_cache
      lambda { VimeoEmbedCache.embed(@valid_attributes[:vid], '100', :static => true) }.should raise_error ArgumentError
    end
    
  end
  
  context "caching" do
    
    it "should fetch embed code if it has no cache for parameters" do
      stub_vimeo_embed_uri '400x200'
      VimeoEmbedCache.embed(@valid_attributes[:vid], '400x200').should_not == @vimeo_embed_cache
      VimeoEmbedCache.embed(@valid_attributes[:vid], '400x200') == "Hello oembed world 400x200"
    end
    
    it "should fetch video from cache" do
      VimeoEmbedCache.embed(@valid_attributes[:vid], @valid_attributes[:geometry]).should == @vimeo_embed_cache
    end
    
    it "should override cache on update_cache" do
      vec = VimeoEmbedCache.find_by_vid(123456)
      vec.code = "Hello"
      vec.save
      vec.update_cache
      vec.code.should_not == "Hello"
    end
    
  end
  
  context "geometry" do
    
    it "should recognize strings like 200, x200 and 300x200" do
      stub_vimeo_embed_uri '400'
      stub_vimeo_embed_uri '400x200'
      stub_vimeo_embed_uri 'x200'
            
      lambda { VimeoEmbedCache.embed(@valid_attributes[:vid], '400') }.should_not raise_error ArgumentError
      lambda { VimeoEmbedCache.embed(@valid_attributes[:vid], 'x200') }.should_not raise_error ArgumentError
      lambda { VimeoEmbedCache.embed(@valid_attributes[:vid], '400x200') }.should_not raise_error ArgumentError
      lambda { VimeoEmbedCache.embed(@valid_attributes[:vid], '400x') }.should raise_error ArgumentError
    end
    
  end

end