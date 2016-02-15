`import Ember from 'ember'`

LibraryController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default LibraryController`
