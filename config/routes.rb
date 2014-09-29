Rails.application.routes.draw do

  get 'home' => 'users#home', as: 'user_root'

  get '(marketplace(/category/:category_id))/marketplace_ajax_sort' => 'marketplace#ajax_sort'
  get 'marketplace(/category/:category_id)' => 'marketplace#index', as: 'marketplace'

  get  'messages/inbox'     => 'messages#index',     as: 'messages'
  get  'messages/sent'      => 'messages#sent_box',  as: 'sent'
  get  'messages/trash'     => 'messages#trash_box', as: 'trash'
  get  'messages/:id'       => 'messages#show',      as: 'message'
  post 'messages/:id'       => 'messages#reply',     as: 'reply_message'
  post 'messages/:id/trash' => 'messages#trash',     as: 'trash_message'

  post 'inquiries/:id' => 'inquiries#create',    as: 'inquiries'

  resources :offers, only: [:index, :show]

  get '(listings(/category/:category_id))/listing_ajax_sort' => 'listings#ajax_sort'
  get 'listings(/category/:category_id)' => 'listings#index', as: 'listings'
  resources :listings, except: [:index]
  # TODO set better url for listing#show
  patch 'listings/remove/:id' => 'listings#remove', as: 'remove_listing'

  # resources :categories, except: [:index, :show]

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'static_pages#home'

  scope path: '/temp', controller: :temp_views do
    get 'photos'           => :photos
    get 'profile'          => :profile
  end

end
