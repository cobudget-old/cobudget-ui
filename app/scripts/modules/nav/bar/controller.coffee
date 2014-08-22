controller = null
`// @ngInject`
controller = ($location, $scope, $rootScope, $routeParams, Budget, BudgetLoader) ->
  BudgetLoader.init($rootScope)

  $scope.$watch 'currentBudgetId', (id) ->
    if id > 0
      $location.path '/budgets/' + id
      BudgetLoader.setBudgetFromArray(id, $scope.budgets)

  Budget.allBudgets().then (budgets) ->
    $scope.budgets = budgets
    if $routeParams.budget_id
      $scope.currentBudgetId = parseInt($routeParams.budget_id) 
    else if $rootScope.currentBudget
      $scope.currentBudgetId = $rootScope.currentBudget.id
    else
      $scope.currentBudgetId = budgets[0].id

module.exports = controller
