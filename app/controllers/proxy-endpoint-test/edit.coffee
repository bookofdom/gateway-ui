`import Ember from 'ember'`

ProxyEndpointTestEditController = Ember.ObjectController.extend
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
    body = vkbeautify.json body if @get 'responseIsJson'
    body = vkbeautify.xml body if @get 'responseIsXml'
    body

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
