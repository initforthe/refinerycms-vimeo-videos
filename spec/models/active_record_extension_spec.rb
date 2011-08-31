require 'spec_helper'
require File.expand_path '../../vimeo_helper', __FILE__

class Project < ActiveRecord::Base
  vimeo_video :video
end

class CreateModels < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :video_id
    end
  end
  
  def self.down
  end
end

ActiveRecord::Base.connection.drop_table("projects") if ActiveRecord::Base.connection.tables.include?("projects")
ActiveRecord::Migration.verbose = false
CreateModels.up

describe "RefinerycmsVimeoVideos ActiveRecord extension" do

  before(:each) do
    ::Refinery::Setting.set(:vimeo_consumer_key, '12345')
    ::Refinery::Setting.set(:vimeo_consumer_secret, 'secret')
    ::Refinery::Setting.set(:vimeo_token, 'token')
    ::Refinery::Setting.set(:vimeo_secret, 'secret')
  end
  
  it "should return nil if new record" do
    project = Project.new
    project.video.should == nil
  end
  
  it "should return value if new record and vimeo id assigned" do
    project = Project.new
    project.video_id = "12345"
    project.video.should == "12345"
  end
  
  it "should not let video be assigned directly" do
    project = Project.new
    lambda { project.video = "100" }.should raise_error NoMethodError
  end
  
  it "should return vimeo meta cache if vimeo id assigned and not new_record?" do
    stub_post("?video_id=123498432&api_key=12345&format=json&method=vimeo.videos.getInfo&api_sig=0f1a7df7325961a0cf352da6264e913f", "advanced/video/get_info.json")
    FakeWeb.register_uri(:get, "http://b.vimeocdn.com/ts/104/602/104602144_640.jpg", :body => "", :content_type => "image/jpeg")
        
    project = Project.create!(:video_id => "123498432")
    
    project.video.class.should == VimeoMetaCache
    project.video.title.should == "Riding High"
  end
  
end