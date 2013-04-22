escapedFragmentExampleApp = angular.module "EscapedFragmentExampleApp", []

escapedFragmentExampleApp.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

escapedFragmentExampleApp.config ($routeProvider) ->
  $routeProvider.when "/escaped-fragment",
    templateUrl: "views/index.html"

  $routeProvider.otherwise
    redirectTo: "/"
