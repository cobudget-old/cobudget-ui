`// @ngInject`
module.exports = ($scope, $rootScope, BudgetLoader) ->
  BudgetLoader.init($rootScope)
  BudgetLoader.loadFromURL()
