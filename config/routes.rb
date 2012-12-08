Dashboardly::Application.routes.draw do

  root :to => 'staticpages#home'

  resources :authorizations
  resources :users
  resources :pages
  resources :sessions
  resources :dashboards do
    resources :pages, :only => [ :show ]
  end


  #Sessions
  delete '/signout', to: 'sessions#destroy', as: :sign_out
  get '/signin' => 'sessions#new', as: :sign_in

  #Static pages
  get '/about' => 'staticpages#about'
  get '/test' => 'staticpages#test'



  # Omniauth 
  match "/auth/:provider/callback" => "sessions#create"
  match '/auth/failure', to: redirect('/')
end

