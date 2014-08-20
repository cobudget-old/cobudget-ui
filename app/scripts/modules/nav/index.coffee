angular = require('angular')

module.exports = angular
  .module('cobudget.nav', [
    require('./bar/index.coffee').name,
  ])
