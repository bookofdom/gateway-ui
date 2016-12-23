`import EditController from 'gateway/pods/edit/controller'`

CustomFunctionEditController = EditController.extend
  executing: false # true while build execution request is in progress
  response: null # holds response from build execution

  reset: -> @set 'response', null

  actions:
    executeBuild: ->
      @set 'response', null
      @set 'executing', true
      @get('model').executeBuild()
        .then (response) =>
          @set 'response', response
        .finally =>
          @set 'executing', false

`export default CustomFunctionEditController`
