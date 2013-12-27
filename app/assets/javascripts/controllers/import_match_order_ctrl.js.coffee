angular.module('importMatchOrder').controller 'importMatchOrderCtrl', ($scope, $interval, $window, ImportMatchOrder) ->
  $scope.checkOrderStatus = ->
    $scope.checking = true
    $scope.matchOrder = ImportMatchOrder.get({}, ->
      $scope.status = $scope.matchOrder.status
      console.log("staus: #{$scope.status}")
      if $scope.status == 'done'
        $window.location.href = $scope.matchOrder.links.report
      else
        $scope.checking = false
    )

  $scope.checkOrderStatus()
  poll = $interval($scope.checkOrderStatus, 5000)
