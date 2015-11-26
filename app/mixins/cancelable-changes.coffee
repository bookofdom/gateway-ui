`import Ember from 'ember'`

CancelableChangesMixin = Ember.Mixin.create
  cancel: ->
    @get('errors').clear()
    @reload().then => @rollback()

`export default CancelableChangesMixin`
