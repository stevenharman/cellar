angular.module('importMatchOrder').factory 'ImportMatchOrder', ($resource) ->
  $resource('/import/match_order')
