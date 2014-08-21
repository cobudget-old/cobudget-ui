fs = require('fs')

`// @ngInject`
module.exports = ->
  {
    restrict: 'EA'
    template: fs.readFileSync(__dirname + '/template.html').toString()
    controller: "BucketListController"
  }
