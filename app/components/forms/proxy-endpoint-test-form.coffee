`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import ProxyEndpointTest from 'gateway/models/proxy-endpoint-test'`
`import t from 'gateway/helpers/i18n'`

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

ProxyEndpointTestFormComponent = BaseFormComponent.extend
  indexModel: null
  routes: null
  modelType: 'proxy-endpoint-test'

  savedAction: null

  'option-groups': Ember.computed 'routes.[]', ->
    method: ProxyEndpointTest.methods
    route: @get('routes').map (route) ->
      name: route.get 'name'
      value: route.get 'path'

  defaultFields: Ember.computed 'routes.[]', ->
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
    newModel = @get('store').createRecord 'proxy-endpoint-test-header'
    model.get('headers').pushObject newModel
  createNewQueryParameterModel: ->
    model = @get 'model'
    newModel = @get('store').createRecord 'proxy-endpoint-test-query-parameter'
    model.get('query').pushObject newModel
  createNewArgumentModel: ->
    model = @get 'model'
    newModel = @get('store').createRecord 'proxy-endpoint-test-argument'
    model.get('arguments').pushObject newModel

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      tests = @get 'indexModel'
      tests.pushObject model
    @_super arguments...

  actions:
    'delete-proxy-endpoint-test-header': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-header': -> @createNewHeaderModel()
    'delete-proxy-endpoint-test-query-parameter': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-query-parameter': -> @createNewQueryParameterModel()
    'delete-proxy-endpoint-test-argument': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-argument': -> @createNewArgumentModel()

`export default ProxyEndpointTestFormComponent`
