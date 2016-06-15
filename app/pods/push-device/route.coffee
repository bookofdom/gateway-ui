`import Ember from 'ember'`

PushDeviceRoute = Ember.Route.extend
  model: (params) -> @modelFor('push-devices').findBy 'id', params.push_device_id
  actions:
    deleted: ->
      @transitionTo 'push-devices'

`export default PushDeviceRoute`
