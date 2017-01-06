`import Ember from 'ember'`
`import EditRoute from 'gateway-ui/pods/edit/route'`

RemoteEndpointEnvironmentDatumScratchPadEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default RemoteEndpointEnvironmentDatumScratchPadEditRoute`
