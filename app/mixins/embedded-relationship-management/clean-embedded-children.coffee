`import Ember from 'ember'`

isFunction = (arg1) ->
  typeof arg1 is 'function'

CleanEmbeddedChildrenMixin = Ember.Mixin.create
  _cleanChildrenOn: Ember.on 'didSave', ->
    @_cleanChildren()

  _rollbackChildrenOn: Ember.on 'didRollback', ->
    @_rollbackChildren()

  _cleanChildren: ->
    @eachDirtyEmbeddedRecord (record) =>
      # Must call `rollbackAttributes` on children since `rollback`
      # is delegated to parents.
      record.rollbackAttributes()
      if isFunction record._cleanChildren
        record._cleanChildren()

  _rollbackChildren: -> @_cleanChildren()

`export default CleanEmbeddedChildrenMixin`
