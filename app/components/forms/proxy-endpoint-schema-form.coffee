`import BaseFormComponent from 'gateway/components/forms/base-form'`

ProxyEndpointSchemaFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint-schema'

  store: Ember.inject.service()

  schemaModel: Ember.computed ->
    store = @get 'store'
    store.createRecord 'json-schema-node',
      title: 'Example Schema'
      type: 'object'
      children: [
        store.createRecord 'json-schema-node',
          name: 'firstName'
          type: 'string'
          required: true
        store.createRecord 'json-schema-node',
          name: 'age'
          type: 'integer'
          minimum: 0
          required: true
        store.createRecord 'json-schema-node',
          name: 'job|occupation'
          pattern_name: true
          type: 'string'
        store.createRecord 'json-schema-node',
          name: 'nickNames'
          type: 'array'
          min_items: 1
          unique_items: true
          children: [
            store.createRecord 'json-schema-node',
              type: 'string'
              pattern: '[\w\s]*'
          ]
      ]

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
