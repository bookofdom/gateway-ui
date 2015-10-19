`import DS from 'ember-data'`

ArrayTransform = DS.Transform.extend
  deserialize: (serialized) ->
    type = Ember.typeOf serialized
    if type == 'array'
      serialized
    else
      []
  serialize: (deserialized) ->
    type = Ember.typeOf deserialized
    if type == 'array'
      deserialized
    else if type == 'string'
      deserialized.split(',').map (item) -> $.trim item
    else
      []

`export default ArrayTransform`
