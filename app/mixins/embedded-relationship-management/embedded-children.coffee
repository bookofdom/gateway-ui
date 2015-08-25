`import Ember from 'ember'`

EmbeddedChildrenMixin = Ember.Mixin.create
  _embeddedChildOptionName: 'embedded'

  # Returns the parent instance that embeds this model instance.
  embeddingParent: Ember.computed ->
    parent = null
    modelName = @constructor.modelName
    @eachRelationshipWithEmbeddingInverse (relationshipName, relationship) =>
      candidateParent = @get relationshipName
      # While there are multiple candidate parent relationships
      # (embedding inverses) only one at a time can resolve a parent.  Or stated
      # differently:  an embedded child may be embedded in only one parent at
      # a time.
      # TODO:  this assumption is only true until it's not.  It is
      # conceivable for a record to be embedded in multiple parents.
      # Because of the difficulty in updating multiply embedded records,
      # we would hope API designers never do this.
      parent ?= candidateParent
    parent

  # Iterates over each relationship where the inverse of the relationship is
  # embedding, indicating a candidate parent relationship.
  eachRelationshipWithEmbeddingInverse: (callback) ->
    @eachRelationship (relationshipName, relationship) =>
      inverseRelationship = @inverseFor(relationshipName)
      inverseRelationshipIsEmbedding =
        inverseRelationship.options[@_embeddedChildOptionName]
      callback relationshipName, relationship if inverseRelationshipIsEmbedding

  eachEmbeddedRelationship: (callback) ->
    embeddedChildOptionName = @_embeddedChildOptionName
    @eachRelationship (relationshipName, relationship) ->
      if relationship.options[embeddedChildOptionName]
        callback relationshipName, relationship

  eachEmbeddedRecord: (callback) ->
    @eachEmbeddedRelationship (relationshipName, relationship) =>
      recordOrRecords = @get relationshipName
      switch relationship.kind
        when 'belongsTo'
          callback recordOrRecords
        when 'hasMany'
          recordOrRecords.forEach (record) -> callback record

  eachDirtyEmbeddedRecord: (callback) ->
    @eachEmbeddedRecord (record) ->
      if record?.get 'hasDirtyAttributes'
        callback record

`export default EmbeddedChildrenMixin`
