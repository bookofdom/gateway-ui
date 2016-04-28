`import BaseFormComponent from 'gateway/components/forms/base-form'`

PushChannelFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'push-channel'
  api: null

  'option-groups': Ember.computed 'api.@each.isNew', 'model.api', 'model.api.remote_endpoints.@each.isNew', ->
    api: @get('api')?.filterBy 'isNew', false
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
      required: true
    ,
      name: 'remote_endpoint'
      type: 'select-model-name'
      required: true
  ]


`export default PushChannelFormComponent`
