Rails.application.routes.draw do

  get 'home' => 'users#home', as: 'user_root'

  post '(category/:category_id)/set_location' => 'marketplace#set_location'
  get '(category/:category_id)/' => 'marketplace#index', as: 'marketplace'
  get '(category/:category_id)/marketplace_ajax_sort' => 'marketplace#ajax_sort', as: 'ajax_sort'
  post 'marketplace/set_coordinates' => 'marketplace#set_coordinates', as: 'set_coords'

  get 'marketplace/:id(/category/:category_id)/' => 'marketplace#show', as: 'user_marketplace'
  get 'marketplace/:id(/category/:category_id)/marketplace_ajax_sort' => 'marketplace#ajax_sort'

  get  'messages/inbox'       => 'messages#index',        as: 'messages'
  get  'messages/sent'        => 'messages#sent_box',     as: 'sent'
  get  'messages/trash'       => 'messages#trash_box',    as: 'trash'
  post 'messages/send/:id'    => 'messages#send_message', as: 'send_message'
  post 'messages/empty_trash' => 'messages#empty_trash',  as: 'empty_trash'
  get  'messages/:id'         => 'messages#show',         as: 'message'
  post 'messages/:id'         => 'messages#reply',        as: 'reply_message'
  post 'messages/:id/trash'   => 'messages#trash',        as: 'trash_message'

  post 'inquiries/:id' => 'inquiries#create',    as: 'inquiries'

  get 'offers/sent' => 'offers#sent', as: 'sent_offers'
  resources :offers, only: [:index, :show]

  # get 'listings(/category/:category_id)' => 'listings#index', as: 'listings'
  # get 'listings(/category/:category_id)/listing_ajax_sort' => 'listings#ajax_sort'

  resources :listings, except: [:index]

  get   'listings/:id/remove' => 'listings#confirm_remove', as: 'confirm_remove'
  patch 'listings/:id/remove' => 'listings#remove',         as: 'remove_listing'
  put   'listings/:id/remove' => 'listings#remove'

  post 'donations/:listing_id'        => 'donations#create', as: 'donations'
  post 'donations/:listing_id/thanks' => 'donations#show',   as: 'donation'
  post 'donation_notifications'       => 'donation_notifications#create'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'faq'     => 'static_pages#faq'
  get 'terms'   => 'static_pages#terms'

  root 'marketplace#index'

  scope path: '/temp', controller: :temp_views do
    get 'photos'           => :photos
    get 'profile'          => :profile
  end

end
