`// @ngInject`
@controller = ($location, $scope, $rootScope, User, UserLoader) ->
  $rootScope.user_id = 1
  UserLoader.init($rootScope)
  UserLoader.loadFromEmail()
  $scope.currentUserId = 1

controller = @controller

window.Cobudget.Directives.Login = ->
  {
    restrict: 'EA'
    templateUrl: '/scripts/directives/login/login.html'
    controller: controller
  }