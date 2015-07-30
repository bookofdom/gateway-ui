`import FormController from 'gateway/controllers/form'`
`import ProxyEndpointTest from '../../models/proxy-endpoint-test'`

ProxyEndpointTestFormController = FormController.extend
  needs: ['proxy-endpoint', 'proxy-endpoint-tests']
  modelType: 'proxy-endpoint-test'
  'option-groups': Ember.computed 'controllers.proxy-endpoint.routes.@each', ->
    method: ProxyEndpointTest.methods
    route: @get('controllers.proxy-endpoint.routes').map (route) ->
      name: route.get 'name'
      value: route.get 'path'
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
  methodFields: Ember.computed 'method', ->
    'POST': [
      name: 'content_type'
    ]
    'PUT': [
      name: 'content_type'
    ]

  fields: Ember.computed 'isNew', 'method', 'methodFields', ->
    fields = @_super.apply @, arguments
    methodFields = @get "methodFields.#{@get 'method'}"
    fields = Ember.copy(fields).pushObjects methodFields if methodFields
    fields

  defaultContentType: Ember.observer 'method', ->
    method = @get 'method'
    @set 'content_type', 'application/json' if (method is 'POST') or (method is 'PUT')

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
