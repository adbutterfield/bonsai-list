 Rails.application.routes.draw do

  root 'static_pages#home'
  get 'home' => 'users#home', as: 'user_root'

  get '(marketplace(/:category_id))/ajax_sort' => 'marketplace#ajax_sort'

  get 'marketplace/:category_id(/:subcategory_id)' => 'marketplace#index', as: 'marketplace_filter'

  get 'marketplace' => 'marketplace#index', as: 'marketplace'

  get 'listings/set_subcategories' => 'listings#set_subcategories', as: 'set_subcategories'
  get 'listings/:id/set_subcategories' => 'listings#set_subcategories'

  resources :listings
  # TODO set better url for listing#show
  # get '/:category/:subcategory_id/:id' => 'listings#show', as: 'listing'
  patch 'listings/remove/:id' => 'listings#remove', as: 'remove_listing'

  resources :subcategories

  resources :categories

  devise_for :users

  scope path: '/temp', controller: :temp_views do
    get 'messages_index'   => :messages_index
    get 'messages_show'    => :messages_show
    get 'offers_index'     => :offers_index
    get 'offers_show'      => :offers_show
    get 'photos'           => :photos
    get 'profile'          => :profile
    get 'user_marketplace' => :user_marketplace
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
