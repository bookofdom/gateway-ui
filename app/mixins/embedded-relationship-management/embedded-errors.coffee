`import Ember from 'ember'`

EmbeddedErrorsMixin = Ember.Mixin.create
  _embeddedChildOptionName: 'embedded'

  onInit: Ember.on 'init', ->
    embeddedChildOptionName = @_embeddedChildOptionName
    @eachRelationship (relationshipName, relationship) =>
      if relationship.options[embeddedChildOptionName]
        @addObserver "errors.#{relationshipName}", =>
          @get(relationshipName).forEach (child) -> child.get('errors').clear()
          @get('errors').errorsFor(relationshipName)?.forEach (error) =>
            @get(relationshipName).filterBy('hasDirtyAttributes', true).forEach (child) ->
              child.get('errors').add 'base', error.message

`export default EmbeddedErrorsMixin`
