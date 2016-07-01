`import Ember from 'ember'`

PushDevicesController = Ember.Controller.extend
  breadCrumb: 'resources.push-device_plural'

  'option-groups': Ember.computed 'remote_endpoints', ->
    push_platforms = []
    @get('remote_endpoints').map (remote_endpoint) ->
      remote_endpoint.get('push_platform_codenames').map (codename) ->
        push_platforms.push codename if codename not in push_platforms
    type:
      push_platforms.map (codename) ->
        name: codename
        value: codename

`export default PushDevicesController`
