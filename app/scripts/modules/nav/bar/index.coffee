angular = require('angular')

module.exports = angular
  .module("cobudget.nav.bar", [
    "cobudget.budgets.BudgetLoader",
  ])
  .directive('navBar', require('./directive.coffee'))
  .controller('NavBarController', require('./controller.coffee'))
