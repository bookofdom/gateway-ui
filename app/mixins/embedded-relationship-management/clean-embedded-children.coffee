`import Ember from 'ember'`

isFunction = (arg1) ->
  typeof arg1 is 'function'

CleanEmbeddedChildrenMixin = Ember.Mixin.create
  _embeddedChildOptionName: 'embeddedChild'

  _cleanChildrenOn: Ember.on 'didSave', ->
    @_cleanChildren()

  _rollbackChildrenOn: Ember.on 'didRollback', ->
    @_rollbackChildren()

  _cleanChildren: ->
    @_forEachEmbeddedRecord (record) =>
      record.send 'willCommit'
      record.set '_attributes', {}
      record.send 'didCommit'
      if isFunction record._cleanChildren
        record._cleanChildren()

  _rollbackChildren: ->
    @_forEachEmbeddedRecord (record) =>
      record.rollback()

  _forEachDirtyEmbeddedRecord: (record) ->
    @_forEachEmbeddedRecord (record) ->
      if record?.get 'hasDirtyAttributes'
        record.send 'willCommit'
        callback record
        record.send 'didCommit'
        # recurse
        if typeof record._cleanChildren is 'function'
          record._cleanChildren()

  _forEachEmbeddedRelationship: (callback) ->
    @eachRelationship (relationshipName, relationship) =>
      if relationship.options[@_embeddedChildOptionName]
        callback relationshipName, relationship

  _forEachEmbeddedRecord: (callback) ->
    @_forEachEmbeddedRelationship (relationshipName, relationship) =>
      recordOrRecords = @get relationshipName
      switch relationship.kind
        when 'belongsTo'
          callback recordOrRecords
        when 'hasMany'
          recordOrRecords.forEach (record) -> callback record

`export default CleanEmbeddedChildrenMixin`
