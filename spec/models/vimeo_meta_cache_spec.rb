require 'spec_helper'

describe VimeoMetaCache do

  def reset_vimeo_meta_cache(options = {})
    @valid_attributes = {
      :id => 1,
      :vid => "123498432"
    }

    @vimeo_meta_cache.destroy! if @vimeo_meta_cache
    @vimeo_meta_cache = VimeoMetaCache.create!(@valid_attributes.update(options))
  end

  before(:each) do
    stub_post("?video_id=123498432&api_key=12345&format=json&method=vimeo.videos.getInfo&api_sig=0f1a7df7325961a0cf352da6264e913f", "advanced/video/get_info.json")
    FakeWeb.register_uri(:get, "http://b.vimeocdn.com/ts/104/602/104602144_640.jpg", :body => "", :content_type => "image/jpeg")
    reset_vimeo_meta_cache
  end
  
  context "caching" do
    
    it "should cache title and description" do
      @vimeo_meta_cache.title.should == "Riding High"
      @vimeo_meta_cache.description.should == "<p>Riding High description</p>"
    end
    
  end

  context "update_cache" do
    
    it "should update title and description if force = true" do
      vmc = VimeoMetaCache.create!(@valid_attributes.merge(:title => "Riding Low", :description => "Low Rider"))
      vmc.update_cache
      vmc.title.should == "Riding High"
      vmc.description.should == "<p>Riding High description</p>"
    end
    
  end

end