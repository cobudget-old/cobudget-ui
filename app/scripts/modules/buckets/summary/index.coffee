angular = require('angular')

module.exports = angular
  .module("cobudget.buckets.summary", [])
  .directive('bucketSummary', require('./directive.coffee'))
