# Dashing

[![Code Climate](https://codeclimate.com/github/gottfrois/dashing-rails.png)](https://codeclimate.com/github/gottfrois/dashing-rails)
[![Coverage Status](https://coveralls.io/repos/gottfrois/dashing-rails/badge.png?branch=master)](https://coveralls.io/r/gottfrois/dashing-rails?branch=master)
[![Build Status](https://travis-ci.org/gottfrois/dashing-rails.png?branch=master)](https://travis-ci.org/gottfrois/dashing-rails)
[![Flattr Button](http://api.flattr.com/button/button-compact-static-100x17.png "Flattr This!")](https://flattr.com/thing/2339949/gottfroisdashing-rails-on-GitHub)
[![Dependency Status](https://gemnasium.com/gottfrois/dashing-rails.svg)](https://gemnasium.com/gottfrois/dashing-rails)
[![codementor-button](https://www.codementor.io/d/images/badge-dark.png "Codementor")](https://www.codementor.io/gottfrois?utm_campaign=profile&utm_source=button-gottfrois&utm_medium=dark)

Dashing-rails is the Rails Engine version of [Dashing by Shopify](http://shopify.github.io/dashing/).
A huge thanks to Shopify for their great work with the Sinatra version.

**Warning**: To upgrade from `2.2.x` to `2.3.x` please read `CHANGELOG.md`.

<img src="https://dl.dropboxusercontent.com/u/29838807/dashing-rails.png" width="600" />

## Introduction

Dashing is a Rails engine that lets you build beautiful dashboards.

[Click here for a video tutorial on how to use this gem:](http://devcasts.co/dashing-rails-making-dashingly-handsome-dashboards/)

[![dashing-rails-devcast](http://devcasts.co/wp-content/uploads/2014/03/dashing-rails.png)](http://devcasts.co/dashing-rails-making-dashingly-handsome-dashboards/)

Check out a demo over [here](http://dashingdemo.herokuapp.com/sample). [Here's another one](http://dashingdemo.herokuapp.com/sampletv), optimized for 1080p screens.

Key features:

* Use premade widgets, or fully create your own with scss, html, and coffeescript.
* Widgets harness the power of data bindings to keep things DRY and simple. Powered by batman.js.
* Use the API to push data to your dashboards, or make use of a simple ruby DSL for fetching data.
* Drag & Drop interface for re-arranging your widgets.
* Host your dashboards on Heroku in less than 30 seconds.

## Requirements

* Ruby >=1.9.3
* Rails 4
* Redis
* Multi Threaded server ([puma](https://github.com/puma/puma), [rainbows](http://rainbows.rubyforge.org/))


## Getting Started

1. Install the gem by adding the following in your `Gemfile`:

```ruby
gem 'dashing-rails'
```

2. Install puma server by adding the following in your `Gemfile`:

```ruby
gem 'puma'
```

3. Bundle install

```
$ bundle
```

4. Install the dependencies using the following command:

```
$ rails g dashing:install
```

5. Start redis server:

```
$ redis-server
```

6. Open `config/environments/development.rb` and add:

```ruby
config.allow_concurrency = true
```

7. Start your server (must be a multi threaded server - See [Requirements](https://github.com/gottfrois/dashing-rails#requirements))

```
$ rails s
```

8. Point your browser at [http://localhost:3000/dashing/dashboards](http://localhost:3000/dashing/dashboards) and have fun!


**Important Note:** *We need to update the configuration in development to handle multiple requests at the same time. One request for the page we’re working on, and another request for the Server Sent Event controller.*

- - -

Every new Dashing project comes with sample widgets & sample dashboards for you to explore. The directory is setup as follows:

* `app/views/dashing/dashboards` — One .erb file for each dashboard that contains the layout for the widgets.
* `app/jobs` — Your ruby jobs for fetching data (e.g for calling third party APIs like twitter).
* `app/assets/javascripts/dashing/widgets/` — A widget's name `.coffee` file containing your widget's js.
* `app/assets/stylesheets/dashing/widgets/` — A widget's name `.scss` file containing your widget's css.
* `app/views/dashing/widgets/` — A widget's name `.html` file containing your widget's html.
* `app/views/layouts/dashing/` — All your custom layouts where your dashboards and widgets will be included.

## Getting Data Into Your Widgets

Providing data to widgets is easy. You specify which widget you want using a widget id, and then pass in the JSON data. There are two ways to do this:

### Jobs

Dashing uses [rufus-scheduler](http://rufus.rubyforge.org/rufus-scheduler/) to schedule jobs. You can make a new job with `rails g dashing:job sample_job`, which will create a file in the jobs directory called `sample_job.rb`.

Example:

```ruby
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
Dashing.scheduler.every '1m', first_in: 1.second.since do |job|
  Dashing.send_event('karma', { current: rand(1000) })
end
```

This job will run every minute, and will send a random number to ALL widgets that have `data-id` set to `"karma"`.

You send data using the following method:

```ruby
Dashing.send_event(widget_id, json_formatted_data)
```

Jobs are where you put stuff such as fetching metrics from a database, or calling a third party API like Twitter. Since the data fetch is happening in only one place, it means that all instances of widgets are in sync.

[Server Sent Events](http://www.html5rocks.com/en/tutorials/eventsource/basics/) are used in order to stream data to the dashboards.

### Redis

Dashing uses [Redis](http://redis.io/) to push and pull data and feed your widgets. Since Dashing [Requirements](https://github.com/gottfrois/dashing-rails#requirements) can be quite frustrating, I thought it might be useful to use redis.

This way you can have a seperate Rails 4 application (with puma) running your dashboards and push your data to redis from your main Rails 3 application for example.

You can specify Dashing redis credentials in `config/initializers/dashing.rb`:

```ruby
config.redis_host     = '127.0.0.1'
config.redis_port     = '6379'
config.redis_password = '123456'
```

By default Dashing subscribed to the following namespace in redis:

```
dashing_events.*
```

where `*` can be anything. This give you all the flexibility you need to push to redis. For example the `send_event` method provided by Dashing uses the following namespace:

```ruby
redis.publish("dashing_events.create", {})
```

You can configure the redis namespace in `config/initializers/dashing.rb`:

```ruby
config.redis_namespace = 'your_redis_namespace'
```

### API

#### Widgets

Your widgets can be updated directly over HTTP. Post the data you want in json to `/dashing/widgets/widget_id`. For security, you will also have to include your `auth_token` (which you can generate in `config/initializers/dashing.rb`).

Example:

```
curl -X PUT http://localhost:3000/dashing/widgets/welcome -d "widget[text]=Dashing is awesome"
```

or

```
curl -X PUT http://localhost:3000/dashing/widgets/karma -d "widget[current]=100" -d "auth_token=YOUR_AUTH_TOKEN"
```

or

```ruby
HTTParty.post('http://localhost:3000/dashing/widgets/karma',
  body: { auth_token: "YOUR_AUTH_TOKEN", current: 1000 }.to_json)
```

#### Dasboards

The `reload` action provided by [Shopify Dashing](http://shopify.github.io/dashing/) is currently not available.

## Create a new Widget

In order to create or add a custom widget to dashing-rails, simply follow the following steps:

1. Run

        $ rails g dashing:widget my_widget

2. Edit `app/views/dashing/widgets/my_widget.html`

3. Edit `app/assets/javascripts/dashing/widgets/my_widget.coffee`

4. Edit `app/assets/stylesheets/dashing/widgets/my_widget.scss`

You can also install pre-package widget compatible with dashing-rails. Here is [a list of all Dashing-Rails compatible Widgets](https://github.com/gottfrois/dashing-rails/wiki).

*Note: the paths may be different depending on your dashing-rails configuration. Check your `config/initializers/dashing.rb` file.*

## Additional Resources

Check out the [wiki](https://github.com/gottfrois/dashing-rails/wiki) for interesting tips such as hosting on Heroku, adding authentication or adding custom widgets.

## Browser Compatibility

Tested in Chrome, Safari 6+, and Firefox 15+.

Does not work in Internet Explorer because it relies on [Server Sent Events](http://www.html5rocks.com/en/tutorials/eventsource/basics/).

## Contributors

* [Shopify Dashing official page](http://shopify.github.io/dashing/)
* [Dashing-rails contributors](https://github.com/gottfrois/dashing-rails/contributors)
* [Shopify Dashing contributors](https://github.com/Shopify/dashing/graphs/contributors)

Special thanks to [Benjamin Roth](https://github.com/apneadiving) for his ideas and support.

All contributions are more than welcome; especially new widgets!

Please add spec to your Pull Requests and run them using:

    $ rake

## License

Dashing is released under the [MIT license](https://github.com/gottfrois/dashing-rails/blob/master/MIT-LICENSE)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/gottfrois/dashing-rails/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

