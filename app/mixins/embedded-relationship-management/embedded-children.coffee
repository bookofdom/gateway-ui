`import Ember from 'ember'`

EmbeddedChildrenMixin = Ember.Mixin.create
  _embeddedChildOptionName: 'embedded'

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

  _forEachDirtyEmbeddedRecord: (callback) ->
    @_forEachEmbeddedRecord (record) ->
      if record?.get 'hasDirtyAttributes'
        callback record

`export default EmbeddedChildrenMixin`
