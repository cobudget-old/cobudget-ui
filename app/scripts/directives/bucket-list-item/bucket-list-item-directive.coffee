`// @ngInject`
@controller = ($scope) ->
	$scope.$watch 'bucket.my_allocation_total', (newValue, oldValue) ->
		allocation_goal = $scope.bucket.allocation_goal
		$scope.bucket.percentage_funded = Math.round(newValue / allocation_goal * 100)

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