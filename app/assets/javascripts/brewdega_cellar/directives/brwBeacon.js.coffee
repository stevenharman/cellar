angular.module('brewdegaCellar')
  .directive 'brwBeacon', ($animate)->
    restrict: 'AE'
    replace: true
    scope: { pulseEvent: '@' }
    template: '<div class="beacon"><div class="dot"></div><div class="ring"></div></div>'
    link: (scope, element, attrs)->
      scope.pulseFinished = ->
        $animate.removeClass(element, 'pulse')

      scope.$on scope.pulseEvent, (event, msg)->
        $animate.addClass(element, 'pulse', scope.pulseFinished)

