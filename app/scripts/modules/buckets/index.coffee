
angular = require('angular')

module.exports = angular.module('cobudget.buckets', [
  "Restangular",
  require('./list/index.coffee').name,
  require('./summary/index.coffee').name,
])
  .controller('BucketShow', require('./controllers/show.coffee'))
  .service("Bucket", require('./resources.coffee'))
