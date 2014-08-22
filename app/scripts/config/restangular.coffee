`// @ngInject`
module.exports = (RestangularProvider, config) ->
  RestangularProvider.setBaseUrl(config.apiEndpoint)
  RestangularProvider.setDefaultHttpFields
    withCredentials: true
