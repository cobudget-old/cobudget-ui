module.exports = (params) ->
  template: require('./unarchive-bucket-dialog.html')
  scope: params.scope
  controller: (Dialog, $location, $mdDialog, $scope, Toast) ->

    $scope.cancel = ->
      $mdDialog.cancel()

    $scope.proceed = ->
      $scope.cancel()
      $scope.bucket.archive()
        .then ->
          Toast.show('Bucket Unarchived!')
        .catch ->
          Dialog.alert({title: "Error!"})
