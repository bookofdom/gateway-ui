`import Ember from 'ember'`

PushChannelIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'push-channel.edit'

`export default PushChannelIndexRoute`
