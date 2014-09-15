Rails.application.routes.draw do


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

  resources :categories, except: [:index, :show]

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'static_pages#home'

  scope path: '/temp', controller: :temp_views do
    get 'messages_index'   => :messages_index
    get 'messages_show'    => :messages_show
    get 'offers_index'     => :offers_index
    get 'offers_show'      => :offers_show
    get 'photos'           => :photos
    get 'profile'          => :profile
    get 'user_marketplace' => :user_marketplace
  end

end
