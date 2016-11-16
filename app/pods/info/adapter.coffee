`import ApplicationAdapter from 'gateway/pods/application/adapter'`

InfoAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default InfoAdapter`
