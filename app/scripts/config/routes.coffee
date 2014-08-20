`// @ngInject`
module.exports = ($routeProvider) ->
  $routeProvider
    .when '/budgets/:budget_id',
      templateUrl: '/views/budget-overview.html'
      controller: require('../modules/budgets/controllers/overview.coffee')
    .when '/budgets/:budget_id/contributors',
      templateUrl: '/views/budget-contributors.html'
      controller: require('../modules/budgets/controllers/contributors.coffee')
    .when '/budgets/:budget_id/my-allocation',
      templateUrl: '/views/budget-allocations.html'
      controller: require('../modules/budgets/controllers/allocations.coffee')
    .when '/buckets/:budget_id',
      templateUrl: '/views/bucket-show.html'
      controller: require('../modules/buckets/controllers/show.coffee')
    .otherwise(redirectTo: '/budgets/1')
