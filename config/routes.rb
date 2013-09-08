Announcify::Application.routes.draw do  
  get "announcements/new"
  get "announcements/edit"
  devise_for :users
  get "dashboard/show"  
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  authenticated :user do
    root :to => "dashboard#show", :as => "authenticated_root"
  end
  root :to => 'static_pages#home'

  resource :announcements, :path => 'announcements'

end
