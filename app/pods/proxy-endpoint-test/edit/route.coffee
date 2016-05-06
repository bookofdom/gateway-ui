`import EditRoute from 'gateway/routes/edit'`

ProxyEndpointTestEditRoute = EditRoute.extend 
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default ProxyEndpointTestEditRoute`
