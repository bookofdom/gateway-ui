`import Ember from 'ember'`

PushIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'push-channels.index'

`export default PushIndexRoute`
