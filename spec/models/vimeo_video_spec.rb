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
    
    it "rejects empty title" do
      VimeoVideo.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_vimeo_video
      VimeoVideo.new(@valid_attributes).should_not be_valid
    end
    
  end

end