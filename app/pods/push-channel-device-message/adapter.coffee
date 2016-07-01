`import ApplicationAdapter from 'gateway/adapters/application'`

PushChannelDeviceMessageAdapter = ApplicationAdapter.extend
  errorMappings:
    data: 'body'

  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_device', 'push_messages'

  ajax: (url, type, options) ->
    hasError = options?.data?.push_message?.dataError
    if hasError
      Ember.RSVP.reject new DS.InvalidError [
        detail: t 'errors.invalid-json'
        source:
          pointer: '/data/attributes/body'
      ]
    else
      @_super arguments...

`export default PushChannelDeviceMessageAdapter`