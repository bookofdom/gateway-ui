`import Ember from 'ember'`

PushChannelPushDevicesController = Ember.Controller.extend
  breadCrumb: 'resources.push-channel-push-device_plural'

  'push-channel': Ember.inject.controller()
  'remote-endpoint': Ember.computed.alias 'push-channel.model.remote_endpoint'

  'option-groups': Ember.computed 'remote-endpoint.push_platform_codenames.[]', ->
    type:
      @get('remote-endpoint.push_platform_codenames').map (codename) ->
        name: codename
        value: codename

`export default PushChannelPushDevicesController`
