angular.module('brewdegaCellar').controller 'importMatchReportCtrl', ($scope, ImportMatchReport) ->

  ImportMatchReport.show().then((report)->
    $scope.matchReport = report
  )
