angular.module('brewdegaCellar').controller 'importMatchOrderCtrl', ($scope, $interval, $location, $window, ImportMatchOrder) ->
  $scope.checkOrderStatus = (options = {})->
    $scope.$broadcast('checkingStatus')
    $scope.matchOrder = ImportMatchOrder.get(options, ->
      status = $scope.matchOrder.status
      if status == 'done'
        $window.location.href = $scope.matchOrder.links.report
    )

  poll = $interval(
    -> $scope.checkOrderStatus($location.search())
    5000)
