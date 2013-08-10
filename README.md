# Dashing

[![Code Climate](https://codeclimate.com/github/gottfrois/dashing-rails.png)](https://codeclimate.com/github/gottfrois/dashing-rails)
[![Coverage Status](https://coveralls.io/repos/gottfrois/dashing-rails/badge.png?branch=master)](https://coveralls.io/r/gottfrois/dashing-rails?branch=master)

Dashing-rails is the Engine version of [Dashing by Shopify](http://shopify.github.io/dashing/).
All credits should go to Shopify for their great work using Sinatra.

## Introduction

Dashing is a Rails engine that lets you build beautiful dashboards.

Check out a demo over [here](http://dashingdemo.herokuapp.com/sample). [Here's another one](http://dashingdemo.herokuapp.com/sampletv), optimized for 1080p screens.

Key features:

* Use premade widgets, or fully create your own with scss, html, and coffeescript.
* Widgets harness the power of data bindings to keep things DRY and simple. Powered by batman.js.
* Use the API to push data to your dashboards, or make use of a simple ruby DSL for fetching data.
* Drag & Drop interface for re-arranging your widgets.
* Host your dashboards on Heroku in less than 30 seconds.

## Getting Started

1. Install the gem by adding the following in your `Gemfile`:

```
gem 'dashing-rails'
```

2. Bundle install

```
$ bundle
```

3. Install the dependecies using the following command:

```
$ rails g dashing:install
```

4. Restart your server (must be a multithreaded server - more on that later)

```
$ thin start
```

5. Point your browser at [http://localhost:3000/dashing/dashboards](http://localhost:3000/dashing/dashboards) and have fun!

- - -

Every new Dashing project comes with sample widgets & sample dashboards for you to explore. The directory is setup as follows:

* **Assets** — All your images, fonts, and js/coffeescript libraries.
* **Dashboards** — One .erb file for each dashboard that contains the layout for the widgets.
* **Jobs** — Your ruby jobs for fetching data (e.g for calling third party APIs like twitter).
* **Widgets** — All the html/css/coffee for individual widgets.
