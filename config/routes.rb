Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :products, only:[:index, :show, :new, :create] do
    resources :comments, module: :products
    resources :orders,  only:[:create, :show]
  end
  resources :orders, only:[:show] do 
    resources :comments, module: :orders
  end

end
