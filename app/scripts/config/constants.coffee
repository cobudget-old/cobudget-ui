angular = require('angular')

angular.module('config', []).constant 'config',
  require('../../config/environments/' + process.env.NODE_ENV)
