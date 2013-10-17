Dashboardly::Application.routes.draw do

  constraints(:host => "mountainmetrics.com") do
    root :to => redirect("http://www.mountainmetrics.com")
    match '/*path', :to => redirect {|params| "http://www.mountainmetrics.com/#{params[:path]}"}
  end

  resources :blog_data_sets

  root :to => 'staticpages#home'

  resources :authorizations
  resources :users
  resources :pages
  resources :sessions
  resources :dashboards do
    resources :pages, :only => [ :show ]
  end

  match "/google" => "authorizations#google"

  # Dashboard
  get '/refresh_blogs' => 'dashboards#refresh_blogs', as: :refresh_blogs

  # Sessions
  delete '/signout', to: 'sessions#destroy', as: :sign_out
  get '/signin' => 'sessions#new', as: :sign_in

  # Static pages
  get '/about' => 'staticpages#about'
  get '/test' => 'staticpages#test'
  get '/demo' => 'staticpages#demo', as: :demo
  get '/demo/page' => 'staticpages#demo_page'
  get '/landing' => 'staticpages#landing'


  # Omniauth
  match "/auth/:provider/callback" => "sessions#create"
  match '/auth/failure', to: redirect('/')
end

