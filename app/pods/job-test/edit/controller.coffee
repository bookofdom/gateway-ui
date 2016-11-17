`import EditController from 'gateway/pods/edit/controller'`

JobTestEditController = EditController.extend
  executing: false # true while test execution request is in progress
  response: null # holds response from test execution

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

`export default JobTestEditController`
