Rails.application.routes.draw do

  get 'home' => 'users#home', as: 'user_root'

  get '(marketplace(/:category_id))/ajax_sort' => 'marketplace#ajax_sort'
  get 'marketplace/:category_id' => 'marketplace#index', as: 'marketplace_filter'
  get 'marketplace' => 'marketplace#index', as: 'marketplace'

  post 'im_interested/:id' => 'messages#im_interested', as: 'im_interested'

  get  'messages/inbox' => 'messages#index',     as: 'messages'
  get  'messages/sent'  => 'messages#sent_box',  as: 'sent'
  get  'messages/trash' => 'messages#trash_box', as: 'trash'
  get  'messages/:id'   => 'messages#show',      as: 'message'
  post 'messages/:id'   => 'messages#reply',     as: 'reply_message'

  resources :offers, only: [:index, :show]

  resources :listings
  # TODO set better url for listing#show
  patch 'listings/remove/:id' => 'listings#remove', as: 'remove_listing'

  # resources :categories, except: [:index, :show]

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
