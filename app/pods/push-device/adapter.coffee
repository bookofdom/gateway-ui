`import ApplicationAdapter from 'gateway/adapters/application'`

PushDeviceAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_channel', 'push_devices'

`export default PushDeviceAdapter`
