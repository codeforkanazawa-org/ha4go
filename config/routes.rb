Rails.application.routes.draw do
  resources :project_updates
  get 'auth/login'

  get 'auth/signup'

  get 'top/index' 

  get 'auth/login', as: 'login'

  get 'auth/signup', as: 'signup'

  get 'user/list', as: 'user_list'

  get 'user/detail/:user_id' => 'user#detail', as: 'user_detail'

  get 'user/edit/:user_id' => 'user#edit', as: 'user_edit'

  get 'project/detail/:project_id' => 'project#detail', as: 'project_detail'

  get 'project/edit', as: 'project_edit'

  get 'project/create', as: 'project_create'

  root 'top#index', as: 'root'

  resources :projects
  resources :users

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
