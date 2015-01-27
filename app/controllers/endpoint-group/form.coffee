`import FormController from 'gateway/controllers/form'`

EndpointGroupFormController = FormController.extend
  needs: ['endpoint-groups']
  modelType: 'endpoint-group'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    endpointGroups = @get 'controllers.endpoint-groups.model'
    endpointGroups.pushObject newModel

`export default EndpointGroupFormController`
