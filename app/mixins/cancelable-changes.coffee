`import Ember from 'ember'`

CancelableChangesMixin = Ember.Mixin.create
  cancel: ->
    # TODO
    # performs rollback/reload as necessary to bring record into clean state

`export default CancelableChangesMixin`
