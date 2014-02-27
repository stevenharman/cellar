angular.module('brewdegaCellar').controller 'importMatchReportCtrl', ($scope, ImportMatchReport) ->

  ImportMatchReport.show().then((report)->
    $scope.matchReport = report
  )

  $scope.selectBrew = (result, match) ->
    brew = result.originalObject
    ImportMatchReport.updateBrew(match, brew).then((b) ->
      angular.copy(brew, match.brew)
      match.isEditing = false
    )

  $scope.edit = (match) ->
   match.isEditing = !match.isEditing

  $scope.confirm = (match) ->
    ImportMatchReport.confirm(match).then((m) ->
      angular.copy(m, match)
    )
