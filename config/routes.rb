Announcify::Application.routes.draw do    
  resources :announcements  
  devise_for :users
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "event/index"
  get "dashboard/show"  
  authenticated :user do
    root :to => "dashboard#show", :as => "authenticated_root"
  end
  root :to => 'static_pages#home'

end
