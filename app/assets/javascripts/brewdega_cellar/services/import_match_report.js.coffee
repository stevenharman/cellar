angular.module('brewdegaCellar').factory 'ImportMatchReport', ($http, $q) ->

  import_match_report_url = '/import/match_report'

  defer = (f)->
    deferred = $q.defer()
    f(deferred)
    return deferred.promise

  show: ()->
    defer (deferred)->
      $http.get(import_match_report_url)
        .success((data)-> deferred.resolve(data.matchReport))
        .error(-> deferred.reject('An error occurred while fetching the match report.'))

  confirm: (match)->
    defer (deferred)->
      $http.post(match.links.confirmation)
        .success((data)-> deferred.resolve(data.match))
        .error(-> deferred.reject("An error occurred while confirming match #{match.id}"))

  updateBrew: (match, newBrew)->
    defer (deferred)->
      $http.put(match.links.brew, {brew: {id: newBrew.id}})
        .success((data)-> deferred.resolve(data.match))
        .error(-> deferred.reject("An error occurred while updating match #{match.id}"))

