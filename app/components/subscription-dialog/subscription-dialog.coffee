module.exports = (params) ->
  template: require('./subscription-dialog.html')
  scope: params.scope
  controller: (Dialog, LoadBar, $location, $mdDialog, $scope, Toast) ->

    $scope.details = [
      'Unlimited group members',
      'Unlimited projects',
      'Priority Email support'
    ]

    $scope.cancel = ->
      $mdDialog.cancel()

    $scope.proceed = ->
      $scope.cancel()
