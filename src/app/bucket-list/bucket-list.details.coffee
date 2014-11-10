angular.module('bucket-list')
  .controller 'BucketListDetailsCtrl', ($scope, $stateParams, getBucket, BucketService) ->
    #$scope.bucket = {id: "1", name:"Fund"}
    $scope.bucket = getBucket