ActionController::Routing::Routes.draw do |map|
  
  map.open_id_complete 'session', :controller => "sessions",:action => "create", :requirements => { :method => :get }
  map.open_id_complete_on_user '/users/add_openid', :controller => 'openids', :action => "create", :requirements => { :method => :get }
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.donate '/donate', :controller => "welcome", :action => "donate"
  map.donate_money '/donate_money', :controller => "welcome", :action => "donate_money"
  map.donate_buy '/donate_buy', :controller => "welcome", :action => "donate_buy"
  map.other '/other', :controller => "welcome", :action => "other"
  map.gmaps '/gmaps',:controller => 'helps', :action => 'gmaps'
  map.recurit '/recurit' , :controller => "welcome", :action => "recruit"
  map.recruit '/recruit' , :controller => "welcome", :action => "recruit"
  # map.recruit_short '/recruit_short' , :controller => "welcome", :action => "recruit_short"
  map.recruit_registrano '/recruit_registrano' , :controller => "welcome", :action => "recruit_registrano"
  map.recruit_long '/recruit_long' , :controller => "welcome", :action => "recruit_long"
  map.recruit_guide '/recruit_guide' , :controller => "welcome", :action => "recruit_guide"
  map.recruit_lucifer '/recruit_lucifer', :controller => "welcome", :action => "recruit_lucifer"
  map.search '/search', :controller => "welcome", :action => "search"  
  map.contact '/contact', :controller => "welcome", :action => "contact"
  map.account_yahooLogin 'account/yahooLogin', :controller => "account",:action => "yahooLogin"
  map.account_yahooAuth 'account/yahooAuth', :controller => "account",:action => "yahooAuth"
  map.plurk '/welcome/plurk', :controller => "welcome", :action => "plurk"
  map.admin '/admin', :controller => "admin"
  
  map.resources :users do |user|
    user.resources :openids
    user.resource :icon, :controller => 'user_icons'
  end
  map.resource :session
  map.resources :counties
  map.resources :helps, :member => {:report => :put}  do |help|
    help.resources :comments, :controller => "HelpComments"
  end

  map.namespace :admin do |admin|
     admin.resources :comments
     admin.resources :helps,:member => {:revert => :put}
     admin.resources :users
     admin.resources :miscs , :member => { :ip => :get , :keywords => :get }
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
  map.home '', :controller => "helps"
  map.root :controller => "helps"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'

end
