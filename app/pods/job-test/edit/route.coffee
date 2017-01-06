`import EditRoute from 'gateway-ui/pods/edit/route'`

JobTestEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default JobTestEditRoute`
