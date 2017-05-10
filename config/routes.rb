Rails.application.routes.draw do

  namespace :admin do
    resources :currencies
  end


  devise_for :users

  post 'configurator/ids=:ids', to: 'configurator#items_to_cart'
  get 'configurator', to: 'configurator#configurator'

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









  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     #   end

  root 'store_mcomputers#store_mcomputers'
end
