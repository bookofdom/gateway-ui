`import EditRoute from 'gateway-ui/pods/edit/route'`

CustomFunctionTestEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default CustomFunctionTestEditRoute`
