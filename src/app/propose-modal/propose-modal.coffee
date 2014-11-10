angular.module('propose-modal', [])
  .controller 'ProposeModalCtrl', ($scope) ->
    $scope.bucket_name= ""
    $scope.submit = () ->
      console.log($scope.text)
      console.log($scope)