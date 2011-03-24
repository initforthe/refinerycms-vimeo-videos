Moxie::Application.routes.draw do
  scope(:path => 'admin', :as => 'admin', :module => 'admin') do
    resources :vimeo_videos, :except => :show do
      collection do
        get :insert
      end
    end
  end
  
  namespace :admin do
    get 'vimeo_videos/authorization', :to => 'vimeo_account#authorization'
    get 'vimeo_videos/callback', :to => 'vimeo_account#callback'
  end
end