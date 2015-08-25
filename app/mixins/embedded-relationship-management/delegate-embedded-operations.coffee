`import Ember from 'ember'`

DelegateEmbeddedOperationsMixin = Ember.Mixin.create
  save: ->
    embeddingParent = @get 'embeddingParent'
    if embeddingParent
      embeddingParent.save()
    else
      @_super.apply @, arguments

  reload: ->
    embeddingParent = @get 'embeddingParent'
    if embeddingParent
      embeddingParent.reload()
    else
      @_super.apply @, arguments

  rollback: ->
    embeddingParent = @get 'embeddingParent'
    if embeddingParent
      embeddingParent.rollback()
    else
      @_super.apply @, arguments

`export default DelegateEmbeddedOperationsMixin`
