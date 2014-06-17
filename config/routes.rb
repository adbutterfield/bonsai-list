Rails.application.routes.draw do
  get 'listings/set_subcategories' => 'listings#set_subcategories', as: 'set_subcategories'

  resources :listings
  # get '/:category/:id' => 'listings#show' as: 'listing'
  patch 'listings/remove/:id' => 'listings#remove', as: 'remove_listing'
  # put 'listings/remove/:id' => 'listings#remove', as: 'remove_listing'
  resources :subcategories

  resources :categories

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'
  get '/home'                  => 'users#home',          as: 'user_root'
  get '/messages'              => 'messages#index',      as: 'messages'
  get '/message'               => 'messages#show',       as: 'message'
  # get '/messages/:id'            => 'messages#show',       as: 'message'
  get '/profile'               => 'users#profile',       as: 'profile'
  get '/profile/photos'        => 'users#photos',        as: 'photo'
  get '/profile/marketplace'   => 'users#marketplace',   as: 'user_marketplace'
  # get '/:id'               => 'users#profile',       as: 'profile'
  # get '/:id/photos'        => 'users#photos',        as: 'photo'
  # get '/:id/marketplace'   => 'users#marketplace',   as: 'user_marketplace'
  get '/marketplace'           => 'products#marketplace',   as: 'marketplace'
  resources :offers
  resources :products
  get 'offers/show'            => 'offers#show'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
