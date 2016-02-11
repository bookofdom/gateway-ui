`import EditController from 'gateway/controllers/edit'`

ScratchPadEditController = EditController.extend
  executing: false # true while test execution request is in progress
  response: null # holds response from test execution

  formattedRequest: Ember.computed 'response.request', ->
    body = @get 'response.request'
    try
      body = vkbeautify.json body
    body

  formattedResponse: Ember.computed 'response.response', ->
    body = @get 'response.response'
    try
      body = vkbeautify.json body
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

`export default ScratchPadEditController`
