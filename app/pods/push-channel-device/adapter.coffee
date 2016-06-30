`import ApplicationAdapter from 'gateway/adapters/application'`

PushChannelDeviceAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_channel', 'push_devices'

`export default PushChannelDeviceAdapter`
