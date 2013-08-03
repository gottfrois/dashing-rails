Dashing::Engine.routes.draw do
  get "/" => "dashing#index"
  get "/views/:widget" => "dashing#widget"
  get "/events" => "dashing#events"
  get "/:dashboard" => "dashing#dashboard"
end
