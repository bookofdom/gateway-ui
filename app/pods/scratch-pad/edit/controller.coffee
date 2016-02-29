`import EditController from 'gateway/controllers/edit'`

ScratchPadEditController = EditController.extend
  executing: false # true while execution is in progress
  result: null # holds result from execution

  formattedRequest: Ember.computed 'result.request', ->
    body = @get 'result.request'
    try
      body = vkbeautify.json body
    body

  formattedResponse: Ember.computed 'result.response', ->
    body = @get 'result.response'
    try
      body = vkbeautify.json body
    body

  reset: -> @set 'result', null

  actions:
    execute: ->
      @set 'result', null
      @set 'executing', true
      @get('model').execute()
        .then (result) =>
          @set 'result', result
        , (result) =>
          @set 'result', result
        .finally =>
          @set 'executing', false

`export default ScratchPadEditController`
