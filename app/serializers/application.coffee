`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  serializeIntoHash: (data, type, record, options) ->
    root = Ember.String.decamelize type.typeKey
    data[root] = @serialize record, options

`export default ApplicationSerializer`
