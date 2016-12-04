Rails.application.routes.draw do

  get 'sessions/create'

  get 'sessions/destroy'

  # OmniAuth
  match 'auth/:provider/callback', to: 'sessions#create', via: 'get'
  match 'auth/failure', to: redirect('/'), via: 'get'
  match 'signout', to: 'sessions#destroy', as: 'signout', via: 'get'

  resources :project_updates

  get 'top/help', as: 'help'

  get 'auth/logout', as: 'logout'

  post 'auth/signup_check', as: 'signup_check'

  post 'auth/login_check', as: 'login_check'

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

  get 'projects/join/:id', to: 'projects#join'

  get 'projects/leave/:id', to: 'projects#leave'

  get 'projects/posts/:id', to: 'projects#kakikomizu'

  get 'feed' => 'top#feed'
  root 'top#index', as: 'root'

  resources :projects
  resources :users

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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
