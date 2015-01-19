`import DS from 'ember-data'`
`import config from  '../config/environment'`

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.api.baseUrl
  pathForType: (type) -> Ember.String.underscore type

`export default ApplicationAdapter`
