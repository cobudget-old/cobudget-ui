`// @ngInject`
window.Cobudget.Controllers.UpdateBucketAllocations = ($scope, $rootscope, Bucket, Budget) ->
  if $route.current.params.id
    $scope.bucket = Bucket.get($route.current.params.id).$object
