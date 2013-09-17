# Use this hook to configure Dashing bahaviors.
Dashing.configure do |config|
  # Scheduler instance.
  # config.scheduler = ::Rufus::Scheduler.new

  # Redis instance.
  # config.redis = ::Redis.new

  # Redis namespace when pushing new data.
  # config.redis_namespace = 'dashing_events'

  # Dashing come with default widgets using css and coffeescript.
  # You can create your own widgets by creating a new folder at the following
  # path by default: `/app/views/dashing/`
  #
  # A widget folder is composed of:
  # - an HTML file used for layout and bindings
  # - a SCSS file for styles
  # - a coffeescript file which allows you to handle incoming data & functionality
  #
  # CSS and JS file will be added to the asset path and the asset pipeline automatically.
  #
  # More information at http://shopify.github.io/dashing/
  # config.view_path = 'app/views/dashing/'

  # rufus-scheduler worker path
  # config.jobs_path = 'app/jobs/'

  # Engine path to use for accessing engine's routes.
  # Ex: http://your_app/dashing/dashboard/my_dashboard_name
  # config.engine_path = '/dashing'

  # The dashboards path used to find dashboards.
  # config.dashboards_path = 'app/views/dashing/dashboards/'

  # The Dashing layout used to display metrics.
  # config.dashboard_layout = 'dashing/dashboard'

  # The widgets path used to find your custom widgets.
  # Dashing provide default widgets.
  # config.widgets_path = 'app/views/dashing/widgets/'

  # Default dashboard name to load when going to /dashing/dashboards
  # config.default_dashboard = nil

  # A secure random string to authenticate with for curl requests.
  # Put nil if you don't want to use authentication.
  # You can use SecureRandom.hex to generate a hex.
  # config.auth_token = nil

  # List of Devise models that should access the whole dashboard.
  # List the models. E.g: '[ :user, :admin ]'
  # config.devise_allowed_models = []
end
