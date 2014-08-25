`// @ngInject`
window.Cobudget.Services.UserLoader = (User)->

  init: ($rootScope) ->
    @rootScope = $rootScope

  loadFromEmail: ->
    self = @
    if self.rootScope.user_id
      User.get(self.rootScope.user_id).then (User) ->
        self.setUser User

  setUser: (User) ->
    @rootScope.currentUser = User