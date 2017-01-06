`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`

InfoAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default InfoAdapter`
