`import FormController from 'gateway/controllers/form'`

EndpointGroupFormController = FormController.extend
  needs: ['endpoint-groups']
  modelType: 'endpoint-group'
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ]
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        endpointGroups = @get 'controllers.endpoint-groups.model'
        endpointGroups.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default EndpointGroupFormController`
