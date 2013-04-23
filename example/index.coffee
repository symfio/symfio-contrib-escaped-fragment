symfio = require "symfio"
path = require "path"
fs = require "fs.extra"

module.exports = container = symfio "example", __dirname
container.set "public directory", path.join __dirname, "public"
container.set "components", [
  "angular#~1.0"
  "jquery#~1.9"
]

loader = container.get "loader"
loader.use require "symfio-contrib-express"
loader.use require "../lib/escaped-fragment"
loader.use require "symfio-contrib-assets"
loader.use require "symfio-contrib-bower"

loader.use (container, callback) ->
  unloader = container.get "unloader"
  app = container.get "app"

  app.get "/", (req, res) ->
    res.send 200

  unloader.register (callback) ->
    fs.remove "#{__dirname}/.components", ->
      fs.remove "#{__dirname}/components", ->
        callback()

  callback()

loader.load() if require.main is module
