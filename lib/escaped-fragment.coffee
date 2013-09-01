phantomProxy = require "phantom-proxy"

module.exports = (container, callback) ->
  proxyConfigs = loadImages: false, debug: process.env.NODE_ENV != "production"
  response = container.get "ping response", "pong"
  logger = container.get "logger"
  app = container.get "app"

  logger.info "loading plugin", "symfio-contrib-escaped-fragment"

  app.use (req, res, callback) ->
    escapedFragment = req.query._escaped_fragment_
    return callback() unless escapedFragment?

    url = "http://127.0.0.1:#{container.get("port")}/#!#{escapedFragment}"
  
    phantomProxy.create proxyConfigs, (proxy) =>
      page = proxy.page
      page.open url, (result) ->
        res.send 500 unless result
        page.evaluate ->
          window.location.hash
        , (hash) ->
          if escapedFragment != hash.replace "#!/", ""
            phantomProxy.end()
            return res.send 404 
          page.evaluate ->
            document.getElementsByTagName('html')[0].outerHTML
          , (content) ->
            phantomProxy.end()
            res.send content

      page.on "loadFinished", (status) ->
        res.send 500 unless status
  
      page.on "error", (err) =>
        res.send 500

  callback()
