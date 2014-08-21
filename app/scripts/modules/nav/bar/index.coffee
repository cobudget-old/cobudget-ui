angular = require('angular')

module.exports = angular
  .module("cobudget.nav.bar", [
    "cobudget.budgets",
  ])
  .directive('navBar', require('./directive.coffee'))
  .controller('NavBarController', require('./controller.coffee'))
