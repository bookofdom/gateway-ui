`import ApplicationAdapter from 'gateway/adapters/application'`
`import t from 'gateway/helpers/i18n'`

TimerAdapter = ApplicationAdapter.extend
  # Raises a JSON serialization error if the serializer
  # reports that one occured.
  ajax: (url, type, options) ->
    hasError = options?.data?.timer?.dataError
    if hasError
      Ember.RSVP.reject new DS.InvalidError [
        detail: t 'errors.invalid-json'
        source:
          pointer: '/data/attributes/attributes'
      ]
    else
      @_super arguments...

`export default TimerAdapter`
