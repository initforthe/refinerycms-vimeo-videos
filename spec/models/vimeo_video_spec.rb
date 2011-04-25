require 'spec_helper'

describe VimeoVideo do

  def reset_vimeo_video(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @vimeo_video.destroy! if @vimeo_video
    @vimeo_video = VimeoVideo.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_vimeo_video
  end

  context "validations" do
    
  end

end