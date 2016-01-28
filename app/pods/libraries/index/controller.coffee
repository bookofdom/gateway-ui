`import Ember from 'ember'`

LibrariesIndexController = Ember.Controller.extend
  filtered: Ember.computed 'model.[]', ->
    model = @get 'model'
    model.filter (library) -> !library.get 'internal'

`export default LibrariesIndexController`
