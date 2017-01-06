`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import t from 'gateway-ui/helpers/i18n'`

PushChannelDeviceMessageAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_device', 'push_messages'

`export default PushChannelDeviceMessageAdapter`
