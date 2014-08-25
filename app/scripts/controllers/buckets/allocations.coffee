`// @ngInject`
window.Cobudget.Controllers.updateMyAllocation = ($scope) ->
  bucket = $scope.bucket
  # update my allocation locally
  bucket.allocations = _.map bucket.allocations, (allocation) ->
    if allocation.id == bucket.my_allocation.id
      allocation.amount = bucket.my_allocation.amount
    return allocation