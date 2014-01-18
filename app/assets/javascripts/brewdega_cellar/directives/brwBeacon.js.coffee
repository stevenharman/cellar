angular.module('brewdegaCellar')
  .directive 'brwBeacon', ($animate, $templateCache)->
    restrict: 'AE'
    replace: true
    scope: { pulseEvent: '@' }
    template: $templateCache.get('brwBeacon')
    link: (scope, element, attrs)->
      scope.pulseFinished = ->
        $animate.removeClass(element, 'pulse')

      scope.$on scope.pulseEvent, (event, msg)->
        $animate.addClass(element, 'pulse', scope.pulseFinished)

