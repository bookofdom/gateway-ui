`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`

PushChannelDeviceMessageAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_device', 'push_messages'

`export default PushChannelDeviceMessageAdapter`
