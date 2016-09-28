`import Ember from 'ember'`

ActionComponentCallIndexRoute = Ember.Route.extend
  afterModel: ->
    prefix = @get 'parentRoute.parentRoute.parentRoute.parentRoute.parentRouteName'
    @transitionTo "#{prefix}-component-call.edit"

`export default ActionComponentCallIndexRoute`
