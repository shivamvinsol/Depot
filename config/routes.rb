Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    get '/users/orders' => 'users#show_user_orders'
    get '/users/line_items' => 'users#show_user_line_items'

    get '/products/show_image' => 'user@show_image'

    resources :users

    resources :products do
      get :who_bought, on: :member
    end

    resources :categories

    resources :admin
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store', via: :all
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
