Prey::Application.routes.draw do

#  get "status/get"

#  match '/:device_id.xml' => "status#get"
  match '/:device_id(.xml)' =>  "status#get"

  resources :devices

  devise_for :users

  get "main/home"

  root :to => 'main#home'


end
