`import Ember from 'ember'`
`import EditRoute from 'gateway/pods/edit/route'`

RemoteEndpointEnvironmentDatumScratchPadEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default RemoteEndpointEnvironmentDatumScratchPadEditRoute`
