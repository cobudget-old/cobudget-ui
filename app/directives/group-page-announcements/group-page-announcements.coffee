null

### @ngInject ###
global.cobudgetApp.directive 'groupPageAnnouncements', () ->
    restrict: 'E'
    template: require('./group-page-announcements.html')
    replace: true
    controller: ($scope, $state, CurrentUser, $mdSidenav, $location, Toast) ->

      $scope.$on 'open announcements', ->
        $mdSidenav('right').open()

      $scope.$on 'open announcements', ->
        $mdSidenav('right').open()

      $scope.accessibleGroups = ->
        CurrentUser() && CurrentUser().groups()

      $scope.redirectToGroupPage = (groupId) ->
        if $state.current.name == 'group' && $scope.group.id == parseInt(groupId)
          $mdSidenav('right').close()
        else
          $location.path("/groups/#{groupId}")

      $scope.currentUser = CurrentUser()
      $scope.announcements = $scope.currentUser.announcements()
      # $scope.announcements = []
      console.log $scope.currentUser
      console.log($scope.announcements)

      $scope.redirectToGroupSetupPage = ->
        $location.path('/setup_group')

      return