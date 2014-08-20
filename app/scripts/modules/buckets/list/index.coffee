angular = require('angular')

module.exports = angular
  .module("cobudget.buckets.list", [])
  .directive('bucketList', require('./directive.coffee'))
  .controller('BucketListController', require('./controller.coffee'))
