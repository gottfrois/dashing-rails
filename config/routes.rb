Dashing::Engine.routes.draw do
  resources :events,      only: [:index, :create]
  # resources :dashboards,  only: [:index, :show]
  # resources :widgets,     only: :show

  get "/" => "dashing#index"
  get "/views/:widget" => "dashing#widget"
  get "/events" => "dashing#events"
  get "/:dashboard" => "dashing#dashboard"
end
