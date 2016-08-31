`import Ember from 'ember'`

KeyController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default KeyController`
