`import FormController from 'gateway/controllers/form'`

ProxyEndpointSchemaFormController = FormController.extend
  'proxy-endpoint-schemas': Ember.inject.controller()
  modelType: 'proxy-endpoint-schema'
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
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        proxyEndpointSchemas = @get 'proxy-endpoint-schemas.model'
        proxyEndpointSchemas.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default ProxyEndpointSchemaFormController`
