ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resource :config
  end
end