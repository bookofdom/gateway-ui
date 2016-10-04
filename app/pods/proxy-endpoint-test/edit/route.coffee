`import EditRoute from 'gateway/pods/edit/route'`

ProxyEndpointTestEditRoute = EditRoute.extend 
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default ProxyEndpointTestEditRoute`
