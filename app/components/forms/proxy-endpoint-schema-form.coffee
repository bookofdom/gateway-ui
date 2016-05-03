`import BaseFormComponent from 'gateway/components/forms/base-form'`

ProxyEndpointSchemaFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint-schema'

  store: Ember.inject.service()
  requestSchemaModel: Ember.computed ->
    store = @get 'store'
    store.createRecord 'json-schema-node',
      title: 'Request Schema'
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
  responseSchemaModel: Ember.computed ->
    store = @get 'store'
    store.createRecord 'json-schema-node',
      title: 'Response Schema'
      type: 'object'
      children: [
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

  editorType: 'code'
  codeEditor: Ember.computed 'editorType', -> @get('editorType') is 'code'
  designEditor: Ember.computed 'editorType', -> @get('editorType') is 'design'

  savedAction: null

  newFields: [
    name: 'name'
    required: true
  ]
  editFields: [
    name: 'name'
    required: true
  ,
    name: 'response_same_as_request'
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      proxyEndpointSchemas = @get 'indexModel'
      proxyEndpointSchemas.pushObject model
    @_super arguments...

  actions:
    activateCodeEditor: ->
      @set 'editorType', 'code'
    activateDesignEditor: ->
      @set 'editorType', 'design'

`export default ProxyEndpointSchemaFormComponent`
