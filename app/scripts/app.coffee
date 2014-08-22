`angular = require('angular')`
`_ = require('lodash')`
ngRoute = require('angular-route')
Restangular = require('restangular')
angularLodash = require('angular-lodash/angular-lodash')
angularFlash = require('angular-flash/dist/angular-flash')
ngCookies = require('angular-cookies')
ngSanitize = require('angular-module-sanitize')
uiRouter = require('angular-ui-router')

module.exports = angular
  .module('cobudget', [
    "ngRoute",
    "restangular",
    "angular-lodash",
    "angular-flash.service", "angular-flash.flash-alert-directive",
    "ngCookies",
    "ngSanitize",
    "ui.router",
    require('./modules/budgets/index.coffee').name,
    require('./modules/buckets/index.coffee').name,
    require('./modules/nav/index.coffee').name,
  ])
  .constant('config', require('./config/constants.coffee'))
  .config(require('./config/restangular.coffee'))
  .config(require('./config/routes.coffee'))
