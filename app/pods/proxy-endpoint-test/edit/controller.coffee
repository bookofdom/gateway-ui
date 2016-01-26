`import Ember from 'ember'`

ProxyEndpointTestEditController = Ember.Controller.extend
  executing: false # true while test execution request is in progress
  response: null # holds response from test execution

  # returns `json`, `xml`, or `text`
  responseType: Ember.computed 'response.headers.@each.name', ->
    contentType = @get('response.headers')?.findBy 'name', 'Content-Type'
    contentType?.value

  responseIsJson: Ember.computed 'responseType', ->
    @get('responseType') is 'application/json'

  responseIsXml: Ember.computed 'responseType', ->
    @get('responseType') is 'application/xml'

  formattedResponseBody: Ember.computed 'response.body', 'responseIsJson', 'responseIsXml', ->
    body = @get 'response.body'
    try
      body = vkbeautify.json body if @get 'responseIsJson'
      body = vkbeautify.xml body if @get 'responseIsXml'
    body

  responseBodyParseError: Ember.computed 'response.body', 'responseIsJson', 'responseIsXml', ->
    try
      body = @get 'response.body'
      vkbeautify.json body if @get 'responseIsJson'
      vkbeautify.xml body if @get 'responseIsXml'
    catch error
      "#{error}"

  reset: -> @set 'response', null

  actions:
    executeTest: ->
      @set 'response', null
      @set 'executing', true
      @get('model').executeTest()
        .then (response) =>
          @set 'response', response
        .finally =>
          @set 'executing', false

`export default ProxyEndpointTestEditController`
