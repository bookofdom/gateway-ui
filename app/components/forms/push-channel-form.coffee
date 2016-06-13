`import BaseFormComponent from 'gateway/components/forms/base-form'`

PushChannelFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'push-channel'
  apis: null

  'option-groups': Ember.computed 'apis.[]', 'model.api', 'model.api.remote_endpoints.[]', ->
    api: @get('apis')?.filterBy 'isNew', false
    'remote_endpoint': @get('model.api.remote_endpoints')?.filterBy('isNew', false).filterBy 'type', 'push'

  defaultFields: [
      name: 'name'
      required: true
    ,
      name: 'expires'
      type: 'datetime'
      required: true
    ,
      name: 'api'
      type: 'select-model-name'
      label: 'resources.api'
      required: true
    ,
      name: 'remote_endpoint'
      type: 'select-model-name'
      label: 'resources.remote-endpoint'
      required: true
  ]


`export default PushChannelFormComponent`
