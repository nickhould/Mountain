Dashboardly::Application.routes.draw do

  root :to => 'staticpages#home'

  resources :authorizations
  resources :users
  resources :pages
  resources :sessions
  resources :dashboards do
    resources :pages, :only => [ :show ]
  end

  match "/google" => "authorizations#google"


  #Sessions
  delete '/signout', to: 'sessions#destroy', as: :sign_out
  get '/signin' => 'sessions#new', as: :sign_in

  #Static pages
  get '/about' => 'staticpages#about'
  get '/test' => 'staticpages#test'
  get '/demo' => 'staticpages#demo', as: :demo


  # Omniauth 
  match "/auth/:provider/callback" => "authorizations#create"
  match '/auth/failure', to: redirect('/')
end

