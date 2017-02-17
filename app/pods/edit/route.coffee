`import Ember from 'ember'`

EditRoute = Ember.Route.extend
  confirm: Ember.inject.service()
  actions:
    willTransition: (transition) ->
      isDirty = @currentModel?.get 'hasDirtyAttributes'
      isAllowedDirty = @currentModel?.get 'isAllowedDirty'
      isDeleted = @currentModel?.get 'isDeleted'
      if isDirty and !isAllowedDirty and !isDeleted
        if @get('confirm').open 'prompts.confirm-abandon'
          @currentModel?.cancel()
          true
        else
          transition.abort()

`export default EditRoute`
