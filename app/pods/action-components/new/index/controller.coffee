`import Ember from 'ember'`

ActionComponentsNewIndexController = Ember.Controller.extend
  prefix: null
  path: Ember.computed 'prefix', ->
    prefix = @get 'prefix'
    "#{prefix}-components.new.type"

`export default ActionComponentsNewIndexController`
