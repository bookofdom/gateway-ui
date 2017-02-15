`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import ProxyEndpointTest from 'gateway-ui/pods/proxy-endpoint-test/model'`

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
  channels: null
  modelType: 'proxy-endpoint-test'

  savedAction: null

  'option-groups': Ember.computed 'routes.[]', 'channels.[]', ->
    method: ProxyEndpointTest.methods
    route: @get('routes').map (route) ->
      name: route.get 'name'
      value: route.get 'path'
    channel: @get('channels').map (channel) ->
      name: channel.get 'full_name'
      value: channel

  defaultFields: Ember.computed 'routes.[]', 'model.channels', ->
    fields = [
      name: 'name'
      required: true
    ,
      name: "channels"
    ]
    if @get 'model.channels'
      fields.pushObjects [
        name: 'method'
        required: true
        type: 'select-name-key'
      ,
        name: 'channel'
        label: 'resources.proxy-endpoint-channel'
        required: true
        type: 'select'
      ]
    else
      fields.pushObjects [
        name: 'method'
        required: true
        type: 'select-name-key'
      ,
        name: 'route'
        label: 'resources.proxy-endpoint-route'
        required: true
        type: 'select'
      ]
    fields

  bodyField:
    name: 'body'
    type: 'editor-text'

  showBodyField: Ember.computed 'model.method', ->
    method = @get 'model.method'
    (method is 'POST') or (method is 'PUT')

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
