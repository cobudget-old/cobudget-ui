angular.module('budget-overview', [])
	.controller 'BudgetOverviewCtrl', ($scope, $stateParams, group) ->
    $scope.groupId = $stateParams.groupId
    $scope.group = group