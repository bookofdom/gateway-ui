`import BaseFormComponent from 'gateway/components/forms/base-form'`

ProxyEndpointSchemaFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint-schema'

  store: Ember.inject.service()

  editorType: 'code'
  codeEditor: Ember.computed 'editorType', -> @get('editorType') is 'code'
  designEditor: Ember.computed 'editorType', -> @get('editorType') is 'design'
  selectedSchema: 'request'
  onSameSchemaChange: Ember.observer 'model.response_same_as_request', ->
    if @get 'model.response_same_as_request'
      @set 'selectedSchema', 'request'
  selectedSchemaModel: Ember.computed 'selectedSchema', 'model.request_json_schema', 'model.response_json_schema', ->
    switch @get 'selectedSchema'
      when 'request' then @get 'model.request_json_schema'
      when 'response' then @get 'model.response_json_schema'

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
    toggleSchema: ->
      if !@get 'model.response_same_as_request'
        switch @get 'selectedSchema'
          when 'request'
            @set 'selectedSchema', 'response'
          when 'response'
            @set 'selectedSchema', 'request'

`export default ProxyEndpointSchemaFormComponent`
