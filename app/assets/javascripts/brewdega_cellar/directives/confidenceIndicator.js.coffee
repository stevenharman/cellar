angular.module('brewdegaCellar')
  .directive 'confidenceIndicator', ($templateCache)->
    icons = {
      high: { name: 'warning', note: 'Exactly one match' }
      medium: { name: 'question-circle', note: 'Multiple matches' }
      none: { name: 'minus-circle', note: 'No matches' }
    }

    restrict: 'AE'
    replace: true
    scope: { confidence: '=confidenceIndicator' }
    template: $templateCache.get('confidenceIndicator')
    link: (scope, element, attrs)->
      scope.icon = icons[scope.confidence]
