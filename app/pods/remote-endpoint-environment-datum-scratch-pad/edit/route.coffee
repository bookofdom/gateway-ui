`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`

RemoteEndpointEnvironmentDatumScratchPadEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default RemoteEndpointEnvironmentDatumScratchPadEditRoute`
