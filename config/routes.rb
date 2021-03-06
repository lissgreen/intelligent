Intelligent::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
#	match ':controller/:action'
	
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
    root :to => "index#index"    

    resources :users do 
      member do 
        get :avatar_new
        put :avatar_create
        post :avatar_cut
        get :fans
        get :follows
      end
    end

    match "session/new",    :controller=>:session, :action=>:new
    match "session/create", :controller=>:session, :action=>:create, :via=>"post"
    match "session/destroy",:controller=>:session, :action=>:destroy, :via=>"delete"

    match "admin/index", :controller=>:admin, :action=>:index

    resources :relatives
    resources :articles do 
      resources :comments
    end
    resources :comments
    resources :topics do 
      resources :pictures
    end
    resources :pictures

    namespace :admin do
      match "start_super/new",    :controller=>:start_super, :action=>:new
      match "start_super/create", :controller=>:start_super, :action=>:create, :via=>"post"
      match "start_super/destroy",:controller=>:start_super, :action=>:destroy, :via=>"delete"
      resources :guides
      resources :users
      resources :articles do
        member do
          put :toggle_allow_comment
          put :toggle_is_pass
        end
      end
      resources :top_pictures
      resources :comments do
        member do
          get :toggle_allow_show
        end
      end
    end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
