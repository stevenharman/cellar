angular.module('brewdegaCellar').controller 'importMatchReportCtrl', ($scope, ImportMatchReport) ->
  $scope.matchReport = ImportMatchReport.get({}, (report, headers)->
    $scope.matchReport = report.matchReport
  )
