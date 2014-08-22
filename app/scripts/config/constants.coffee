angular = require('angular')
fs = require('fs')

config = fs.readFileSync(
  __dirname + '/../../../config/environments/' + process.env.NODE_ENV + '.json'
).toString()

angular.module('config', []).constant 'config',
  JSON.parse(config)
