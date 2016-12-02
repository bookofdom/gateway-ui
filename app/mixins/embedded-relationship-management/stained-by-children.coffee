`import Ember from 'ember'`

StainedByChildrenMixin = Ember.Mixin.create
  hasDirtyAttributes: Ember.computed.or 'currentState.isDirty',
    'hasDirtyChildren',
    'hasChangedBelongsTo'

  isAllowedDirty: Ember.computed.or 'allowedDirty', 'hasAllowedDirtyChildren'

  hasDirtyChildren: false
  hasChangedBelongsTo: null

  _stainingRelationshipDirtyProperties: Ember.computed ->
    relationshipDirtyProperties = []
    @eachRelationship (relationshipName, relationship) ->
      if relationship.options.stains
        relationshipDirtyProperties.push
          kind: relationship.kind
          relationshipName: relationshipName
          propertyName: switch relationship.kind
            when 'belongsTo'
              "#{relationshipName}.hasDirtyAttributes"
            when 'hasMany'
              "#{relationshipName}.@each.hasDirtyAttributes"
    relationshipDirtyProperties

  _setupHasDirtyChildrenProperty: Ember.on 'init', ->
    dirtyProps = @get '_stainingRelationshipDirtyProperties'
    if dirtyProps.length
      reducer = (previousResult, currentValue) =>
        currentResult = switch currentValue.kind
          when 'belongsTo'
            @get currentValue.propertyName
          when 'hasMany'
            reduceMany = (previousResult, currentValue) ->
              previousResult or currentValue.get 'hasDirtyAttributes'
            @get(currentValue.relationshipName).reduce reduceMany, false
        previousResult or currentResult
      computedFn = -> dirtyProps.reduce reducer, false
      computedProps = (prop.propertyName for prop in dirtyProps)
      computedProps.push computedFn
      computed = Ember.computed.apply Ember, computedProps
      Ember.defineProperty @, 'hasDirtyChildren', computed

  # TODO
  # This is a duplication of above except for the property names.
  _setupHasAllowedDirtyChildrenProperty: Ember.on 'init', ->
    dirtyProps = @get '_stainingRelationshipDirtyProperties'
    if dirtyProps.length
      reducer = (previousResult, currentValue) =>
        currentResult = switch currentValue.kind
          when 'belongsTo'
            @get currentValue.propertyName
          when 'hasMany'
            reduceMany = (previousResult, currentValue) ->
              previousResult or currentValue.get 'isAllowedDirty'
            @get(currentValue.relationshipName).reduce reduceMany, false
        previousResult or currentResult
      computedFn = -> dirtyProps.reduce reducer, false
      computedProps = (prop.propertyName for prop in dirtyProps)
      computedProps.push computedFn
      computed = Ember.computed.apply Ember, computedProps
      Ember.defineProperty @, 'hasAllowedDirtyChildren', computed

  _setupHasChangedBelongsToProperty: Ember.on 'init', ->
    dirtyProps = @get '_stainingRelationshipDirtyProperties'
    belongsToProps = dirtyProps.filter (prop) -> prop.kind is 'belongsTo'
    if belongsToProps.length
      computedFn = ->
        isDirty = false
        for prop in belongsToProps
          if !isDirty
            internalRelationship = @get "_internalModel._relationships.initializedRelationships.#{prop.relationshipName}"
            canonicalId = internalRelationship.canonicalState?.id
            inverseId = internalRelationship.inverseRecord?.id
            isDirty = !(canonicalId is inverseId)
        isDirty
      computedProps = ("#{prop.relationshipName}.id" for prop in belongsToProps)
      computedProps.push computedFn
      computed = Ember.computed.apply Ember, computedProps
      Ember.defineProperty @, 'hasChangedBelongsTo', computed

  _rollbackChangedBelongsToOn: Ember.on 'didRollbackAttributes', ->
    @_rollbackChangedBelongsTo()

  _rollbackChangedBelongsTo: ->
    dirtyProps = @get '_stainingRelationshipDirtyProperties'
    belongsToProps = dirtyProps.filter (prop) -> prop.kind is 'belongsTo'
    if belongsToProps.length
      for prop in belongsToProps
        internalRelationship = @get "_internalModel._relationships.initializedRelationships.#{prop.relationshipName}"
        canonicalId = internalRelationship?.canonicalState?.id
        inverseId = internalRelationship?.inverseRecord?.id
        isDirty = !(canonicalId is inverseId)
        if isDirty
          @set prop.relationshipName, internalRelationship.canonicalState.record

`export default StainedByChildrenMixin`
