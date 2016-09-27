`import Ember from 'ember'`

KeysRoute = Ember.Route.extend
  model: -> @store.findAll 'key'

`export default KeysRoute`
