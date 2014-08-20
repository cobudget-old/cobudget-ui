angular = require('angular')

module.exports = angular
  .module("cobudget.budgets", [
    "Restangular",
    require('./banner/index.coffee').name,
  ])
  .service('BudgetLoader', require('./services/loader.coffee'))
  .service("Budget", require('./resources.coffee'))
  .controller("BudgetAllocations", require('./controllers/allocations.coffee'))
  .controller("BudgetContributors", require('./controllers/contributors.coffee'))
  .controller("BudgetOverview", require('./controllers/overview.coffee'))
