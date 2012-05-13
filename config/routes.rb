Rails3BootstrapDeviseCancan::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations", :confirmations => "users/confirmations" } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  resources :users, :only => [:show, :index] do
    resources :posts
  end
end
