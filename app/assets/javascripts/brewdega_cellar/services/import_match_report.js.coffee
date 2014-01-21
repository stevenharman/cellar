angular.module('brewdegaCellar').factory 'ImportMatchReport', ($http, $q) ->
  defer = (f)->
    deferred = $q.defer()
    f(deferred)
    return deferred.promise

  show: ()->
    defer (deferred)->
      $http.get('/import/match_report')
        .success((data)-> deferred.resolve(data.matchReport))
        .error(-> deferred.reject('An error occurred while fetching the match report.'))

  confirm: (match)->
    defer (deferred)->
      $http.post(match.links.confirmation)
        .success((data)-> deferred.resolve(data.match))
        .error(-> deferred.reject("An error occurred while confirming the Match #{match.id}"))
