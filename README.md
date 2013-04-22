# symfio-symfio-contrib-escaped-fragment

> Search engines indexation plugin.

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname
container.set "public directory", path.join __dirname, "public"
container.set "components", [
  "angular#~1.0"
  "jquery#~1.9"
]

loader = container.get "loader"
loader.use require "symfio-contrib-express"
loader.use require "../lib/escaped-fragment"
loader.use require "symfio-contrib-assets"
loader.use require "symfio-contrib-bower"

loader.use (container, callback) ->
  app = container.get "app"

  app.get "/", (req, res) ->
    res.send "Escaped fragment"

  callback()

loader.load()
```

## Also you should configure you angular project like that:

```coffee
escapedFragmentApp = angular.module "EscapedFragmentApp", []

escapedFragmentApp.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

escapedFragmentApp.config ($routeProvider) ->
  # Yout must configure redirect if route doesn't match.
  # $routeProvider.otherwise
  #   redirectTo: "/"

  # Or define special route.
  $routeProvider.when "/404",
    templateUrl: "404.html"

  $routeProvider.otherwise
    redirectTo: "/404"
```

## Required plugins

* [contrib-express](https://github.com/symfio/symfio-contrib-express)
* [contrib-assets](https://github.com/symfio/symfio-contrib-assets)
* [contrib-bower](https://github.com/symfio/symfio-contrib-bower)
