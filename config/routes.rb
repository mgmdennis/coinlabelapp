Rails.application.routes.draw do
  get '/'=> 'coins#index'
  get '/coins' => 'coins#index'
  get '/coins/print' => 'coins#print', as: :print_coins
  get '/coins/new' => 'coins#new', as: :new_coin
  get '/coins/:id' => 'coins#edit', as: :coin
  get '/coins/:id/edit' => 'coins#edit', as: :edit_coin
  get '/coins/:id/duplicate' => 'coins#duplicate', as: :duplicate_coin
  delete '/coins/clear' => 'coins#clear', as: :clear_coins
  post '/coins' => 'coins#create'
  patch '/coins/:id' => 'coins#update'
  delete '/coins/:id/delete' => 'coins#destroy', as: :delete_coin
  post '/coins/new/fastinput' => 'coins#fastinput', as: :fastinput_coin
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  #     resources :products
  #   end
end
