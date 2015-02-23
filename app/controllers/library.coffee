`import Ember from 'ember'`

LibraryController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default LibraryController`
