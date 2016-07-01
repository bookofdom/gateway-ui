`import ApplicationAdapter from 'gateway/adapters/application'`

PushChannelMessageAdapter = ApplicationAdapter.extend
  errorMappings:
    data: 'body'

  ajax: (url, type, options) ->
    hasError = options?.data?.push_channel_message?.dataError
    if hasError
      Ember.RSVP.reject new DS.InvalidError [
        detail: t 'errors.invalid-json'
        source:
          pointer: '/data/attributes/body'
      ]
    else
      @_super arguments...

`export default PushChannelMessageAdapter`