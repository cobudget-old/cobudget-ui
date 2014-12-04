http = require('http')
url = require('url')
Path = require('path')
fs = require('fs')
express = require('express')

env = process.env
nodeEnv = env.NODE_ENV or 'development'

if env.NODE_ENV isnt 'production'
  require('debug').enable("*")

module.exports = (options = {}) ->

  root = options.root or __dirname + '/../build'
  cache = options.cache or
    if env.NODE_ENV == 'production' then 3600 else 0

  webapp = express()

  # add livereload middleware if dev
  if (nodeEnv == 'development')
    webapp.use(require('connect-livereload')({
      port: env.LIVERELOAD_PORT or 35729
    }))

  webapp.use(require('ecstatic')({
    root: root
    cache: cache
    showDir: false
    handleError: false
  }))

  # if nothing else matched,
  webapp.use (req, res, next) ->
    res.status(200)
    fs.createReadStream(
      Path.join(root, "index.html")
    ).pipe(res)
