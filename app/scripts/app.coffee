`angular = require('angular')`
`_ = require('lodash')`
ngRoute = require('angular-route')
Restangular = require('restangular')

module.exports = angular
  .module('cobudget', [
    "ngRoute",
    "Restangular",
    require('./modules/budgets/index.coffee').name,
    require('./modules/buckets/index.coffee').name,
    require('./modules/nav/index.coffee').name,
  ])
  .constant('config', require('./config/constants.coffee'))
  .config(require('./config/restangular.coffee'))
  .config(require('./config/routes.coffee'))
