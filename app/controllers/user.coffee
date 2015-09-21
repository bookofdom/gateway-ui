`import Ember from 'ember'`

UserController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default UserController`
