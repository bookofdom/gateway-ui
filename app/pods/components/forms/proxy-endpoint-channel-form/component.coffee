`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

ProxyEndpointChannelFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint-channel'
  'option-groups': null

  fields: [
      name: 'remote_endpoint'
      type: 'select-model-name'
      label: 'resources.remote-endpoint'
      required: true
    ,
      name: 'name'
      required: true
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      channels = @get 'indexModel'
      channels.pushObject model
    @_super arguments...

`export default ProxyEndpointChannelFormComponent`
