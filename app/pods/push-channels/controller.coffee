`import Ember from 'ember'`

PushChannelsController = Ember.Controller.extend
  breadCrumb: 'resources.push-channel_plural'

  remote_endpoint: Ember.observer 'api.@each.remote_endpoints', ->
    remote_endpoint = []
    api = @get 'api'
    api.forEach (item) ->
      item.get('remote_endpoints').forEach (item) ->
        remote_endpoint.pushObject item
    remote_endpoint

`export default PushChannelsController`
