Moxie::Application.routes.draw do
  scope(:path => 'admin', :as => 'admin', :module => 'admin') do
    resources :vimeo_videos, :only => :index
    get 'vimeo_videos/authorization', :to => 'vimeo_account#authorization'
    get 'vimeo_videos/callback', :to => 'vimeo_account#callback'
  end
end