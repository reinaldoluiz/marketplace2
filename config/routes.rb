Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :products, only:[:index, :show, :new, :create] do 
    resources :orders,  only:[:index, :show, :new,:create]
  end
end
