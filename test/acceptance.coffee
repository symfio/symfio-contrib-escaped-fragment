suite = require "symfio-suite"


describe "symfio-contrib-escaped-fragment example", ->
  wrapper = suite.http require "../example"

  describe "GET /?_escaped_fragment_", ->
    it "should respond with content if page exists", wrapper (callback) ->
      test = @http.get "/?_escaped_fragment_=escaped-fragment"
      test.res (res) =>
        @expect(res).to.have.status 200
        @expect(res.text).to.have.string "Content for escaped fragment"
        callback()

    it "should respond with 404 if page doesn't exists", wrapper (callback) ->
      test = @http.get "/?_escaped_fragment_=not-found"
      test.res (res) =>
        @expect(res).to.have.status 404
        callback()
