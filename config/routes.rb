Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/order/comments', to: 'orders/comments#create'
  get 'orders/:order_id/comments/:id', to: 'orders/comments#show'
  resources :products, only:[:index, :show, :new, :create] do
    resources :comments, module: :products
    resources :orders,  only:[:index, :show, :new,:create]do 
      resources :comments, module: :orders
    end
  end

end
