`import Ember from 'ember'`

isFunction = (arg1) ->
  typeof arg1 is 'function'

CleanEmbeddedChildrenMixin = Ember.Mixin.create
  _cleanChildrenOn: Ember.on 'didSave', ->
    @_cleanChildren()

  _rollbackChildrenOn: Ember.on 'didRollback', ->
    @_rollbackChildren()

  _cleanChildren: ->
    @_forEachDirtyEmbeddedRecord (record) =>
      record.send 'willCommit'
      record.set '_attributes', {}
      record.send 'didCommit'
      if isFunction record._cleanChildren
        record._cleanChildren()

  _rollbackChildren: ->
    @_forEachDirtyEmbeddedRecord (record) =>
      record.rollback()

`export default CleanEmbeddedChildrenMixin`
