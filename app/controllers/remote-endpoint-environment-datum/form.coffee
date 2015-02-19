`import FormController from 'gateway/controllers/form'`

RemoteEndpointEnvironmentDatumFormController = FormController.extend
  needs: ['remote-endpoints', 'remote-endpoint-environment-data']
  modelType: 'remote-endpoint-environment-datum'
  'option-groups': Ember.computed 'controllers.remote-endpoints.environments', ->
    environment: @get('controllers.remote-endpoints.environments').filterBy 'isNew', false
  createNewModel: ->
    newModel = @_super.apply @, arguments
    environments = @get 'controllers.remote-endpoint-environment-data.model'
    environments.pushObject newModel

`export default RemoteEndpointEnvironmentDatumFormController`
