`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

ActionComponentCallsIndexController = Ember.Controller.extend
  prefix: null

  path: Ember.computed 'prefix', ->
    prefix = @get 'prefix'
    "#{prefix}-component-call.index"
  'edit-path': Ember.computed 'prefix', ->
    prefix = @get 'prefix'
    "#{prefix}-component-call.edit"

`export default ActionComponentCallsIndexController`
