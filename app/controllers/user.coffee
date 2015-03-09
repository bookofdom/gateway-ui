`import Ember from 'ember'`

UserController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default UserController`
