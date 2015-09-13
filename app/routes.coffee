### @ngInject ###

global.cobudgetApp.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'
  $stateProvider
    .state 'group', require('app/components/group-page/group-page.coffee')
    .state 'welcome', require('app/components/welcome-page/welcome-page.coffee')
    .state 'create-bucket', require('app/components/create-bucket-page/create-bucket-page.coffee')
    .state 'bucket', require('app/components/bucket-page/bucket-page.coffee')
    .state 'edit-bucket', require('app/components/edit-bucket-page/edit-bucket-page.coffee')
    .state 'admin', require('app/components/admin-page/admin-page.coffee')