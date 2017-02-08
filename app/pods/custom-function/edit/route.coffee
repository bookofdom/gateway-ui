`import Ember from 'ember'`
`import EditRoute from 'gateway-ui/pods/edit/route'`

CustomFunctionEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default CustomFunctionEditRoute`
