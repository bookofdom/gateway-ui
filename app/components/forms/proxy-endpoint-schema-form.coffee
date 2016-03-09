`import BaseFormComponent from './base-form'`

ProxyEndpointSchemaFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint-schema'

  savedAction: null

  newFields: [
    name: 'name'
    required: true
  ]
  editFields: [
    name: 'name'
    required: true
  ,
    name: 'request_schema'
    type: 'editor-json'
  ,
    name: 'response_same_as_request'
  ,
    name: 'response_schema'
    type: 'editor-json'
    group: 'response'
  ]
  fields: Ember.computed 'model.isNew', 'model.response_same_as_request', ->
    if @get('model.isNew')
      @get('newFields')
    else if @get('model.response_same_as_request')
      @get('editFields').filter (item) -> item.group isnt 'response'
    else
      @get('editFields')

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      proxyEndpointSchemas = @get 'indexModel'
      proxyEndpointSchemas.pushObject model
    @_super arguments...

`export default ProxyEndpointSchemaFormComponent`
