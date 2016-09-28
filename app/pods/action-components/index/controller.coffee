`import Ember from 'ember'`

ActionComponentsIndexController = Ember.Controller.extend
  prefix: null
  path: Ember.computed 'prefix', ->
    prefix = @get 'prefix'
    "#{prefix}-component.index"
  'edit-path': Ember.computed 'prefix', ->
    prefix = @get 'prefix'
    "#{prefix}-component.edit"

`export default ActionComponentsIndexController`
