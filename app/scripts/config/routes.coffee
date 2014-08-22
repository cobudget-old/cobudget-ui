fs = require('fs')

`// @ngInject`
module.exports = ($routeProvider) ->
  $routeProvider
    .when '/budgets/:budget_id',
      template: fs.readFileSync(__dirname + '/../../views/budget-overview.html').toString()
      controller: require('../modules/budgets/controllers/overview.coffee')
    .when '/budgets/:budget_id/contributors',
      template: fs.readFileSync(__dirname + '/../../views/budget-contributors.html').toString()
      controller: require('../modules/budgets/controllers/contributors.coffee')
    .when '/budgets/:budget_id/my-allocation',
      template: fs.readFileSync(__dirname + '/../../views/budget-allocations.html').toString()
      controller: require('../modules/budgets/controllers/allocations.coffee')
    .when '/buckets/:budget_id',
      template: fs.readFileSync(__dirname + '/../../views/bucket-show.html').toString()
      controller: require('../modules/buckets/controllers/show.coffee')
    .otherwise(redirectTo: '/budgets/1')
