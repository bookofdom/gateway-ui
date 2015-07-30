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
  fields: Ember.computed ->
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
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        tests = @get 'controllers.proxy-endpoint-tests.model'
        tests.pushObject model

`export default ProxyEndpointTestFormController`
