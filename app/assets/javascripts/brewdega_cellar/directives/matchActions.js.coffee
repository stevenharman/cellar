angular.module('brewdegaCellar')
  .directive 'matchActions', ($templateCache)->
    indicators = {
      confirmed: { name: 'check', note: 'Confirmed' }
      high: { name: 'warning', note: 'One match' }
      medium: { name: 'question-circle', note: 'Many matches' }
      none: { name: 'minus-circle', note: 'No matches' }
    }

    restrict: 'AE'
    replace: true
    scope: {
      edit: '&'
      confirm: '&'
      match: '=matchActions'
    }
    template: $templateCache.get('matchActions')
    link: (scope, element, attrs)->
      match = scope.match
      scope.id = match.id

      scope.$watch('match', ->
        scope.confidence = match.confidence
        scope.indicator = indicators[match.confidence]
        scope.isMatched = match.isMatched
        scope.isConfirmable = match.isMatched && !match.isConfirmed
      , true)
