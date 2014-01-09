angular.module('brewdegaCellar').factory 'ImportMatchReport', ($resource) ->
  $resource('/import/match_report')
