Rails.application.routes.draw do

  namespace :admin do
    resources :currencies
  end

  devise_for :users

  post 'configurator/ids=:ids', to: 'configurator#items_to_cart'

  get 'configurator', to: 'configurator#configurator'
  get 'configurator/show_offer/ids=:ids', to: 'configurator#show'

  resources :order_items, only: [:create, :update, :destroy]

  get 'cart/sale_id=:sale_id', to: 'carts#sale'

  resource :cart

  namespace :admin do
    resources :categories
    resources :sub_categories
    resources :sales

    controller :product_features do
      get 'product_features/product=:product', to: 'product_features#index'
      get 'product_features/product=:product/page=:page', to: 'product_features#index'
      resources :product_features
    end

    resources :extract_xmls do
      post :extract_xml_file, on: :member
      post :update_products, on: :member
      get  :delete_all_products, on: :collection
    end

    get '', to: 'admin#admin'
    get '/:product', to: 'products#index'

    resources :products
  end

  resources :store_mcomputers

  controller 'store_mcomputers' do
    get '/search/', to: 'store_mcomputers#list'
    get '/product=:product', to: 'store_mcomputers#list'
    get '/product=:product/filter=:filter', to: 'store_mcomputers#list'
    get '/product=:product/page=:page', to: 'store_mcomputers#list'
  end

  root 'store_mcomputers#store_mcomputers'
end
