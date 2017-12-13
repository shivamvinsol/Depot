Rails.application.routes.draw do
  constraints user_agent: /Firefox/ do
    root 'store#index'
    match "*url" => redirect('/404'), via: :all
  end

  scope '(:locale)' do

    get 'admin' => 'admin#index'

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    get '/users/orders' => 'users#show_user_orders'
    get '/users/line_items' => 'users#show_user_line_items'

    # FIXME: same action as /users/orders for /my-orders
    # get '/my-orders' =>   redirect('/users/orders')

    # get '/users/ratings' => 'ratings#index', as: 'user_ratings_path'

    get 'my-items' => redirect('users/line_items')
    get 'admin/reports' => 'admin#show_reports', as: :admin_report
    get 'admin/categories' => 'admin#show_categories'
    get 'categories/:id/books' => 'categories#show_products', id: /\d+/, as: :category_products
    get 'categories/:id/books' => redirect('/')

    post 'admin/api/reports' => 'admin#get_orders_between_dates'
    post '/api/product/rate' => 'ratings#update_or_create'

    resources :users
    resources :products, path: 'books' do
      get :who_bought, on: :member
    end

    resources :admin
    resources :categories
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store', via: :all
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# get '/products/show_image' => 'products#show_image'
