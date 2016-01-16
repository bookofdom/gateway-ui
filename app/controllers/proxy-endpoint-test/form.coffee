`import FormController from 'gateway/controllers/form'`
`import ProxyEndpointTest from '../../models/proxy-endpoint-test'`
`import t from '../../helpers/i18n'`

# Field Rules
#
# body shows when:
# method is POST or PUT
#
# headers show when:
# always
#
# query params show if:
# the method is GET, POST or PUT

ProxyEndpointTestFormController = FormController.extend
  'proxy-endpoint': Ember.inject.controller()
  'proxy-endpoint-tests': Ember.inject.controller()
  modelType: 'proxy-endpoint-test'

  'option-groups': Ember.computed 'proxy-endpoint.model.routes.[]', ->
    method: ProxyEndpointTest.methods
    route: @get('proxy-endpoint.model.routes').map (route) ->
      name: route.get 'name'
      value: route.get 'path'

  defaultFields: Ember.computed 'proxy-endpoint.model.routes.[]', ->
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

  bodyField:
    name: 'body'
    type: 'editor-text'

  showBodyField: Ember.computed 'model.method', ->
    method = @get 'model.method'
    ((method is 'POST') or (method is 'PUT'))

  showQueryParameters: Ember.computed 'model.method', ->
    method = @get 'model.method'
    method != 'DELETE'

  createNewHeaderModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-header'
    model.get('headers').pushObject newModel
  createNewQueryParameterModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-query-parameter'
    model.get('query').pushObject newModel
  createNewArgumentModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-argument'
    model.get('arguments').pushObject newModel
  actions:
    'delete-proxy-endpoint-test-header': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-header': -> @createNewHeaderModel()
    'delete-proxy-endpoint-test-query-parameter': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-query-parameter': -> @createNewQueryParameterModel()
    'delete-proxy-endpoint-test-argument': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-argument': -> @createNewArgumentModel()
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        tests = @get 'proxy-endpoint-tests.model'
        tests.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default ProxyEndpointTestFormController`
