ActionController::Routing::Routes.draw do |map|
  
  # User routes
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resource :session
  map.resources :password_resets
  
  # Country and state routes
  Country.slugs.each do |slug|
    map.send(slug.gsub('-', '_'), "/developers/#{slug}", :controller => "countries", :action => "show", :country => slug)
  end
  
  State.slugs.each do |slug|
    map.send(slug.gsub('-', '_'), "/developers/us-#{slug}", :controller => "states", :action => "show", :state => slug)
  end
  
  # App routes
  map.resource :home, :controller => 'home'
  map.resource :provider_directory, :as => :developer_directory, :controller => "provider_directory"
  map.resources :providers, :as => :developers, :shallow => true, :collection => {:search => :get, :by_location => :get} do |provider|
    provider.resources :recommendations
    provider.resources :portfolio_items
  end  
  map.resources :rfps
  map.resources :pages, :requirements => { :id => /.*/}
  
  # Provider admin routes
  map.my '/my', :controller => 'my/dashboard', :action => 'show'
  map.namespace :my do |me|
    me.resource :dashboard, :controller => 'dashboard'
    me.resource :provider, :as => :developer
    me.resources :portfolio_items
    me.resources :endorsement_requests
    me.resources :users
    me.resources :recommendations, :collection => {:sort => :put, :update_all => :put}
    me.resources :requests
  end
  
  # Admin routes
  map.admin '/admin', :controller => 'admin/dashboard', :action => 'show'
  map.change_password '/admin/change_password', :controller => 'admin/users', :action => 'change_password'
  map.namespace :admin do |admin|
    admin.resource :dashboard, :controller => 'dashboard'
    admin.resources :services
    admin.resources :users, :member => [:take_control, :resend_welcome]
    admin.resources :portfolio_items
    admin.resources :rfps
    admin.resources :recommendations
    admin.resources :providers do |provider|
      provider.resources :users
      provider.resources :portfolio_items
      provider.resources :requests
      provider.resources :recommendations
    end
    admin.resources :pages
    admin.resource :csv
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "my/dashboard", :action => 'show'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
