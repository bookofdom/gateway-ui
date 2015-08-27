`import Ember from 'ember'`

StainedByChildrenMixin = Ember.Mixin.create
  hasDirtyAttributes: Ember.computed 'currentState.isDirty', 'hasDirtyChildren', ->
    @get('currentState.isDirty') or @get('hasDirtyChildren')

  hasDirtyChildren: false

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

`export default StainedByChildrenMixin`
