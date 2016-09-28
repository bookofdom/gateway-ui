`import Ember from 'ember'`

ActionComponentCallsRoute = Ember.Route.extend
  model: -> @get 'parentModel.calls'

`export default ActionComponentCallsRoute`
