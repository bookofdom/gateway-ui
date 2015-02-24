`import FormController from 'gateway/controllers/form'`

EndpointGroupFormController = FormController.extend
  needs: ['endpoint-groups']
  modelType: 'endpoint-group'
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        endpointGroups = @get 'controllers.endpoint-groups.model'
        endpointGroups.pushObject model

`export default EndpointGroupFormController`
