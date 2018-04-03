Rails.application.routes.draw do
  resources :orders
  resources :buckets
  resources :wishlists
  get 'pages/info'
  post 'rate' => 'products#rate'
  post 'addtobucket' => 'buckets#addtobucket'
  post 'deletebucket' => 'buckets#deletebucket'
  post 'addtowishlist' => 'wishlists#addtowishlist'
  post 'deletewishlist' => 'wishlists#deletewishlist'
  post 'compare' => 'wishlists#compare'
  post 'delcompare' => 'wishlists#delcompare'
	root to: 'ewlcome#index'
	devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_for :users
  resources :comments
  resources :products
  post 'checkout' => 'orders#checkout'
  get 'payment/:id' => 'orders#payment'
  get 'payment/create2/:id' => 'orders#create2'
  get 'administration' => 'wishlists#administration'
  get 'adm_search' => 'wishlists#adm_search'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
