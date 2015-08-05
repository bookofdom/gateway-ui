`import Ember from 'ember'`

ProxyEndpointTestEditController = Ember.ObjectController.extend
  executing: false # true while test execution request is in progress
  response: null # holds response from test execution

  # returns `json`, `xml`, or `text`
  responseType: Ember.computed 'response.headers.@each.name', ->
    contentType = @get('response.headers')?.findBy 'name', 'Content-Type'
    value = contentType?.value
    type = 'text'
    type = 'json' if value is 'application/json'
    type = 'xml' if value is 'application/json'

  formattedResponseBody: Ember.computed 'response.body', 'responseType', ->
    body = @get 'response.body'
    body

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
