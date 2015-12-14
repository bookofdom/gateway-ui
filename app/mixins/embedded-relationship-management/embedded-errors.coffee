`import Ember from 'ember'`

EmbeddedErrorsMixin = Ember.Mixin.create
  _embeddedChildOptionName: 'embedded'
  _embeddedErrorsOptionName: 'errors'

  onInit: Ember.on 'init', ->
    embeddedChildOptionName = @_embeddedChildOptionName
    embeddedErrorsOptionName = @_embeddedErrorsOptionName
    @eachRelationship (relationshipName, relationship) =>
      if relationship.options[embeddedChildOptionName] and relationship.options[embeddedErrorsOptionName]
        @addObserver "errors.#{relationshipName}", =>
          @get(relationshipName).forEach (child) -> child.get('errors').clear()
          @get('errors').errorsFor(relationshipName)?.forEach (error) =>
            @get(relationshipName).filterBy('hasDirtyAttributes', true).forEach (child) ->
              child.get('errors').add 'base', error.message

`export default EmbeddedErrorsMixin`
