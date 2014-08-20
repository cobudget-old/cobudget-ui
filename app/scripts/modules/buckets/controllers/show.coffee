`// @ngInject`
module.exports = ($scope, $route, Bucket) ->
  if $route.current.params.id
    $scope.bucket = Bucket.get($route.current.params.id).$object
