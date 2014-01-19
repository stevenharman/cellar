angular.module('brewdegaCellar')
  .directive 'matchIndicator', ($templateCache)->
    icons = {
      confirmed: { name: 'check', note: 'Confirmed' }
      high: { name: 'warning', note: 'One match' }
      medium: { name: 'question-circle', note: 'Many matches' }
      none: { name: 'minus-circle', note: 'No matches' }
    }

    restrict: 'AE'
    replace: true
    scope: { match: '=' }
    template: $templateCache.get('matchIndicator')
    link: (scope, element, attrs)->
      match = scope.match
      scope.confidence = match.confidence
      scope.icon = icons[match.confidence]
