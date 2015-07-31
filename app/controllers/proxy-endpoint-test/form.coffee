`import FormController from 'gateway/controllers/form'`
`import ProxyEndpointTest from '../../models/proxy-endpoint-test'`
`import t from '../../helpers/i18n'`

# Field Rules
#
# content_type shows if:
# method is POST or PUT
#
# content_type resets to null or empty when (model-level enforcement):
# method is GET or DELETE
#
# body shows when:
# method is POST or PUT and content-type is not 'application/x-www-form-urlencoded'
#
# headers show when:
# always
#
# query params show if:
# the method is GET
# or the method is POST or PUT and content type is 'application/x-www-form-urlencoded'

ProxyEndpointTestFormController = FormController.extend
  needs: ['proxy-endpoint', 'proxy-endpoint-tests']
  modelType: 'proxy-endpoint-test'

  # selectable content type provides convenient access to
  # common content types via select, with the option to
  # choose "other" and enter the content type directly
  selectableContentTypeOberver: Ember.observer 'selectable_content_type', ->
    contentType = @get 'content_type'
    selectableContentType = @get 'selectable_content_type'
    if (selectableContentType != 'custom') and (contentType != selectableContentType)
      @set 'content_type', selectableContentType
    if selectableContentType is 'custom'
      @set 'content_type', null
  contentTypeObserver: Ember.observer 'content_type', 'isJson', 'isXml', 'isFormEncoded', ->
    contentType = @get 'content_type'
    selectableContentType = @get 'selectable_content_type'
    isJson = @get 'isJson'
    isXml = @get 'isXml'
    isFormEncoded = @get 'isFormEncoded'
    if (selectableContentType != 'custom') and (contentType != selectableContentType) and (isJson or isXml or isFormEncoded)
      @set 'selectable_content_type', contentType

  'option-groups': Ember.computed 'controllers.proxy-endpoint.routes.@each', ->
    method: ProxyEndpointTest.methods
    route: @get('controllers.proxy-endpoint.routes').map (route) ->
      name: route.get 'name'
      value: route.get 'path'
    selectable_content_type: [
      name: 'application/json'
      value: 'application/json'
    ,
      name: 'application/xml'
      value: 'application/xml'
    ,
      name: 'application/x-www-form-urlencoded'
      value: 'application/x-www-form-urlencoded'
    ,
      name: t 'actions.specify-custom'
      value: 'custom'
    ]

  defaultFields: Ember.computed 'controllers.proxy-endpoint.routes.@each', ->
    [
      name: 'name'
      required: true
    ,
      name: 'method'
      required: true
      type: 'select'
    ,
      name: 'route'
      label: 'resources.proxy-endpoint-route'
      required: true
      type: 'select'
    ]
  methodFields:
    'POST': [
      name: 'selectable_content_type'
      label: 'fields.content_type'
      type: 'select'
    ]
    'PUT': [
      name: 'selectable_content_type'
      label: 'fields.content_type'
      type: 'select'
    ]
  contentTypeFields: Ember.computed 'selectable_content_type', ->
    selectableContentType = @get 'selectable_content_type'
    if selectableContentType is 'custom'
      [
        name: 'content_type'
      ]
  bodyFields: Ember.computed 'method', 'bodyLanguage', ->
    method = @get 'method'
    bodyLanguage = @get 'bodyLanguage'
    if bodyLanguage and ((method is 'POST') or (method is 'PUT'))
      [
        name: 'body'
        type: "editor-#{bodyLanguage}"
      ]

  bodyLanguage: Ember.computed 'selectable_content_type', ->
    language = 'text' if !@get 'isFormEncoded'
    language = 'json' if @get 'isJson'
    language = 'xml' if @get 'isXml'
    language

  fields: Ember.computed 'isNew', 'method', 'methodFields', 'contentTypeFields', 'bodyFields', ->
    fields = @_super.apply @, arguments
    methodFields = @get "methodFields.#{@get 'method'}"
    contentTypeFields = @get 'contentTypeFields'
    bodyFields = @get 'bodyFields'
    fields = Ember.copy(fields).pushObjects methodFields if methodFields
    fields = fields.pushObjects contentTypeFields if contentTypeFields
    fields = fields.pushObjects bodyFields if bodyFields
    fields

  defaultContentType: Ember.observer 'method', ->
    method = @get 'method'
    @set 'content_type', 'application/json' if (method is 'POST') or (method is 'PUT')

  showQueryParameters: Ember.computed 'method', 'isFormEncoded', ->
    method = @get 'method'
    (method is 'GET') or (@get('isFormEncoded') and ((method is 'POST') or (method is 'PUT')))

  createNewHeaderModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-header'
    model.get('headers').pushObject newModel
  createNewQueryParameterModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-query-parameter'
    model.get('query').pushObject newModel
  actions:
    'delete-proxy-endpoint-test-header': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-header': -> @createNewHeaderModel()
    'delete-proxy-endpoint-test-query-parameter': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-query-parameter': -> @createNewQueryParameterModel()
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        tests = @get 'controllers.proxy-endpoint-tests.model'
        tests.pushObject model

`export default ProxyEndpointTestFormController`
