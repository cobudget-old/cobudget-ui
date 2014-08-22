angular = require('angular')

module.exports = angular
  .module('cobudget.budgets.banner', [])
  .directive('budgetBanner', require('./directive.coffee'))
