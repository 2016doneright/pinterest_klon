Rails.application.routes.draw do
  
  resources :boards
  
  devise_for :users

  resources :comments, only: [:create, :destroy]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :pins do 
    resources :comments, only: [:create, :destroy]
    member do
      put     :like,   to: "pins#like",   as: "like_this"
      delete  :unlike, to: "pins#unlike", as: "unlike_this"
    end
  end
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :repins, only: [:create]
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
   get '/:profile_name', to: 'profiles#show', as: 'gimme_profile'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  
  scope '/:profile_name' do
    get 'following_users', to: 'profiles#following', as: 'following_users'
    get 'followers', to: 'profiles#followers', as: 'users_followers'
    get 'likes', to: 'profiles#likes', as: 'likes_pins'
    get 'pins', to: 'profiles#pins', as: 'all_pins'
    get 'boards', to: 'profiles#boards', as: 'has_boards'
    get 'following_boards', to: 'profiles#following_boards', as: 'following_boards'
  end
  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  put :follow,              to: "profiles#follow",            as: "follow_person"
  put :stop_following,      to: "profiles#stop_following",    as: "unfollow_person"
  
  put :follow_board,              to: "boards#follow_board",            as: "follow_board"
  put :stop_following_board,      to: "boards#stop_following_board",    as: "unfollow_board"
  
  authenticated :user do
    root to: 'base#feed', as: :authenticated_root
  end
  
  root 'profiles#guest'
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
