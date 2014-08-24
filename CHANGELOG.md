## 2.4.0

* Update Batman.js using `batman-rails` gem
* Fixes [#41](https://github.com/gottfrois/dashing-rails/issues/41) for good. We now don't have to use proc or lambdas anymore.

## 2.3.2

* Fixes [#46](https://github.com/gottfrois/dashing-rails/issues/46)

## 2.3.1

* Patch redis child connection when using passenger

## 2.3.0

* Remove all `Rails.root` occurance and move them to configuration file. Please use a proc or a lambda in the configuration since `Rails` module might not be defined when configuration file is required.

## 2.2.0

* Add dashing layout to the installer (re run `rails g dashing:install` if you want to have the dashing default layout file)

## 2.1.1

* Fix font awesome not included in the asset pipeline

## 2.1.0

* Upgrade font awesome to use the 4.0.x version

## 2.0.2

* Fix bin rails polution
* Improve rails engine and railtie

## 2.0.1

* Fix default widgets javascript files not required

## 2.0.0

* Refactor assets management. Now they all live in `vendor` directory.
* Introduce a widget generator to build custom widget in a few seconds (`rails g dashing:widget my_widget`).
* Rename configuration attributes (you need to regenerate the initializer config file with `rails g dashing:install`)
* Simplify widget view path
* Bug fixes

## 1.0.3

* cherrypick https://github.com/Shopify/dashing/pull/253
* cherrypick https://github.com/Shopify/dashing/commit/2b715ac63dd2de5c718142822663dbded44bbecd
* cherrypick https://github.com/Shopify/dashing/commit/9f93895bd40aad02e88f7ed7bfd954c930aa27db
* cherrypick https://github.com/Shopify/dashing/commit/9496b31d7787182b561bd99f8674901bd7667976
* cherrypick https://github.com/Shopify/dashing/pull/181
* cherrypick https://github.com/Shopify/dashing/commit/3af326da84251069c4e6f7464d0ae8506b20e98b
* cherrypick https://github.com/Shopify/dashing/pull/211

## 1.0.2

* Fix redis connection. Now using connection pool
* Allow redis custom connection using custom redis host, port and password.
