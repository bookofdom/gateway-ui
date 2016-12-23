`import Ember from 'ember'`
`import EditRoute from 'gateway/pods/edit/route'`

CustomFunctionEditRoute = EditRoute.extend
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default CustomFunctionEditRoute`
