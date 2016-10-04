`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

ProxyEndpointRouteFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint-route'

  fields: [
      name: 'path'
      required: true
    ,
      name: 'methods'
      type: 'methods'
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      routes = @get 'indexModel'
      routes.pushObject model
    @_super arguments...

`export default ProxyEndpointRouteFormComponent`
