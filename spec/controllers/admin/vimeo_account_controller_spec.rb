require 'spec_helper'
require 'factory_girl'
Dir[File.expand_path('../../../../features/support/factories.rb', __FILE__)].each {|f| require f}
require File.expand_path '../../../vimeo_helper', __FILE__

include Devise::TestHelpers

describe Admin::VimeoAccountController do

  def reset(options = {})
    FakeWeb.clean_registry
    RefinerySetting.delete_all
    login_user
  end
  
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = Factory.create(:refinery_user)
    sign_in user
  end

  before(:each) do
    reset
  end
    
  it "should not ask for authorization if not ready" do
    get :authorization
    
    response.should be_redirect
    flash[:alert].should_not == nil
  end
  
  it "should redirect if ready to authorize" do
    RefinerySetting.set(:vimeo_consumer_key, '0fdb4f200cc52ae06cd3dfa74e680feb')
    RefinerySetting.set(:vimeo_consumer_secret, 'e6cdebf36a8cdd6b')
    
    stub_custom_get("/oauth/request_token", "advanced/auth/request_token.txt")
    
    get :authorization
    
    response.should redirect_to('http://vimeo.com/oauth/authorize?permission=delete&oauth_token=12345')
  end
  
  it "should redirect to /admin if already authorized" do
    RefinerySetting.set(:vimeo_consumer_key, '0fdb4f200cc52ae06cd3dfa74e680feb')
    RefinerySetting.set(:vimeo_consumer_secret, 'e6cdebf36a8cdd6b')
    RefinerySetting.set(:vimeo_token, '0ea53d3415ce2c60625ddc649730e1b9')
    RefinerySetting.set(:vimeo_secret, '97ce681f949aadb4e56e764b897a6e4463df0a7b')
    
    get :authorization

    response.should redirect_to('/admin')
    flash[:notice].should_not == nil
  end
  
end