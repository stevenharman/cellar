angular.module('brewdegaCellar').controller 'importMatchReportCtrl', ($scope, ImportMatchReport) ->

  ImportMatchReport.show().then((report)->
    $scope.matchReport = report
  )

  $scope.confirm = (match) ->
    ImportMatchReport.confirm(match).then((m) ->
      angular.copy(m, match)
    )
