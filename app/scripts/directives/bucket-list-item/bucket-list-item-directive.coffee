`// @ngInject`
@controller = ($scope) ->
  $scope.$watch 'bucket.my_allocation_total', (bucket) ->
  	console.log(bucket)

controller = @controller

window.Cobudget.Directives.BucketListItem = ->
  {
    restrict: 'EA'
    templateUrl: '/scripts/directives/bucket-list-item/bucket-list-item.html'
    controller: controller
    scope: {
    	bucket: '='
    }
  }