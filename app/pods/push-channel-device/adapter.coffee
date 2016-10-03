`import ApplicationAdapter from 'gateway/pods/application/adapter'`

PushChannelDeviceAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_channel', 'push_devices'

`export default PushChannelDeviceAdapter`
