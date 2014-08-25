`// @ngInject`
@controller = ($scope, Bucket) ->
	$scope.$watch 'bucket.my_allocation.amount', (newValue, oldValue) ->
		# Bucket.updateMyAllocation($scope.bucket, newValue)
		# update my allocation locally
		$scope.bucket.allocations = _.map $scope.bucket.allocations, (allocation) ->
		  if allocation.id == $scope.bucket.my_allocation.id
		    allocation.amount = $scope.bucket.my_allocation.amount
		  return allocation
		$scope.bucket.percentage_funded = Bucket.getPercentageFunded($scope.bucket)

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