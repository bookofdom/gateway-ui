`import DS from 'ember-data'`
`import config from  '../config/environment'`

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.api.baseUrl
  pathForType: (type) -> Ember.String.underscore type
  ajaxError: (xhr, responseText) ->
    error = @_super.apply @, arguments
    if xhr?.status == 422
      response = Ember.$.parseJSON responseText
      new DS.InvalidError response
    else
      error

`export default ApplicationAdapter`
