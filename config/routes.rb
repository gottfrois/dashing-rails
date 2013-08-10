Dashing::Engine.routes.draw do
  resources :events,      only: [:index, :create]
  resources :dashboards,  only: [] do
    get '/:name', action: :show, on: :collection
  end
  resources :widgets,     only: [] do
    get '/:name', action: :show, on: :collection
  end

  root to: 'dashboard#index'

  # get "/" => "dashing#index"
  # get "/views/:widget" => "dashing#widget"
  # get "/events" => "dashing#events"
  # get "/:dashboard" => "dashing#dashboard"
end
