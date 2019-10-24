Rails.application.routes.draw do
 get "gallery" => "events#gallery"
 get 'contact' => "events#contact"
 post 'contact' => 'events#post_mail'
 get   'events' =>  'events#events'
 root "events#index"
 resources :categories
 resources :users
 resource :session
 resources :events do 
     resources :registrations
     resources :likes
     resources :comments
 end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
