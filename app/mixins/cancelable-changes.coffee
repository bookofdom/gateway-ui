`import Ember from 'ember'`

CancelableChangesMixin = Ember.Mixin.create
  cancel: -> @reload().then => @rollback()

`export default CancelableChangesMixin`
