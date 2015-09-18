`import RemoteEndpointLikeFormController from '../remote-endpoint-like/form'`

RemoteEndpointEnvironmentDatumFormController = RemoteEndpointLikeFormController.extend
  'api': Ember.inject.controller()
  'remote-endpoint': Ember.inject.controller()
  'remote-endpoint-environment-data': Ember.inject.controller()
  modelType: 'remote-endpoint-environment-datum'

  'option-groups': Ember.computed 'api.environments.@each.isNew', ->
    Ember.merge @_super.apply(@, arguments),
      environment: @get('api.environments').filterBy 'isNew', false

  defaultFields:
    [
      name: 'environment'
      label: 'resources.environment'
      type: 'select-model-name'
      required: true
    ]

  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        environmentData = @get 'remote-endpoint-environment-data.model'
        model.set 'type', @get('remote-endpoint.model.type')
        environmentData.pushObject model
    afterSave: ->
      @notifySaveSuccess()
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'

`export default RemoteEndpointEnvironmentDatumFormController`
