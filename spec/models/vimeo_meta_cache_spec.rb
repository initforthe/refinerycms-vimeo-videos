require 'spec_helper'

describe VimeoMetaCache do

  def reset_vimeo_meta_cache(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @vimeo_meta_cache.destroy! if @vimeo_meta_cache
    @vimeo_meta_cache = VimeoMetaCache.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_vimeo_meta_cache
  end

  context "validations" do
    
    
  end

end