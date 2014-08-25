`// @ngInject`
@controller = ($rootScope, $scope, Budget) ->
  $rootScope.$watch 'currentBudget', (budget) ->
    return unless budget
    Budget.getBudgetBuckets(budget.id).then (buckets) ->
      _.each buckets, (bucket) ->
        bucket.my_allocation = {
          amount: 100
          bucket_id: bucket.id
        }
        bucket.allocations = [bucket.my_allocation]
        bucket.percentage_funded = 20
        bucket.allocation_goal = 200

      $scope.buckets = buckets

controller = @controller

window.Cobudget.Directives.BucketList = ->
  {
    restrict: 'EA'
    templateUrl: '/scripts/directives/bucket-list/bucket-list.html'
    controller: controller
  }
