Rails.application.routes.draw do
  scope(:module => 'refinery') do
    scope(:module => 'admin', :path => 'refinery', :as => 'refinery_admin') do    
      resources :vimeo_videos, :except => :show do
        collection do
          get :insert
        end
      end
    end
  end
end