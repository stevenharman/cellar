angular.module('importMatchOrder').controller 'importMatchOrderCtrl', ($scope, $interval, $location, $window, ImportMatchOrder) ->
  $scope.checkOrderStatus = (options = {})->
    $scope.checking = true
    $scope.matchOrder = ImportMatchOrder.get(options, ->
      status = $scope.matchOrder.status
      if status == 'done'
        $window.location.href = $scope.matchOrder.links.report
      else
        $scope.checking = false
    )

  poll = $interval(
    -> $scope.checkOrderStatus($location.search())
    5000)
