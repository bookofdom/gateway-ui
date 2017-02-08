`import EditController from 'gateway-ui/pods/edit/controller'`

CustomFunctionEditController = EditController.extend
  reset: ->
    model = @get 'model'
    customFunctionBuild = @store.createRecord 'custom-function-build'
    customFunctionBuild.set 'custom_function', model
    @set 'custom_function_build', customFunctionBuild

  actions:
    executeBuild: ->
      @reset()
      @get('custom_function_build').executeBuild()
      false

`export default CustomFunctionEditController`
