@brewdegaCellar = angular.module('brewdegaCellar', ['ngAnimate', 'ngResource', 'brewdegaCellar.templates'])

# HACK: Rails currently ignores Accept headers when they contain '*/*', so we
# must send the xhr header to force it to respect the 'application/json' media
# type that AngularJS sends. See: # https://github.com/rails/rails/issues/9940
@brewdegaCellar.config ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'

@brewdegaCellar.config ($locationProvider) ->
  $locationProvider.html5Mode(false).hashPrefix('!')
