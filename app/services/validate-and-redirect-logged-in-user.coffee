null

### @ngInject ###

global.cobudgetApp.factory 'ValidateAndRedirectLoggedInUser', ($auth, Error, LoadBar, $location, Records, CurrentUser) ->
  ->
    LoadBar.start()
    Error.clear()
    $auth.validateUser()
      .then ->
        global.cobudgetApp.membershipsLoaded.then (data) ->
          # groupId = data.groups[0].id
          groupId = CurrentUser().primaryGroup().id
          $location.path("/groups/#{groupId}")
          LoadBar.stop()
      .catch ->
        LoadBar.stop()
