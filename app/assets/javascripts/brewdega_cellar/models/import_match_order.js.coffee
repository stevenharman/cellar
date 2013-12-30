angular.module('brewdegaCellar').factory 'ImportMatchOrder', ($resource) ->
  $resource('/import/match_order')
