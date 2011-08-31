Refinery::Application.routes.draw do
  scope(:module => 'refinery') do
    scope(:module => 'admin', :path => 'refinery', :as => 'refinery_admin') do
      get 'vimeo_videos/authorization', :to => 'vimeo_account#authorization'
      get 'vimeo_videos/callback', :to => 'vimeo_account#callback'
    
      resources :vimeo_videos, :except => :show do
        collection do
          get :insert
        end
      end
    end
  end
end