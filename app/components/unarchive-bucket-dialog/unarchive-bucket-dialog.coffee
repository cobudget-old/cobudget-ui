module.exports = (params) ->
  template: require('./unarchive-bucket-dialog.html')
  scope: params.scope
  controller: (Dialog, LoadBar, $location, $mdDialog, $scope, Toast) ->

    $scope.cancel = ->
      $mdDialog.cancel()

    $scope.proceed = ->
      $scope.cancel()
      LoadBar.start()
      $scope.bucket.archive()
        .then ->
          LoadBar.stop()
          Toast.show('Bucket Unarchived!')
        .catch ->
          Dialog.alert({title: "Error!"})
          LoadBar.stop()
