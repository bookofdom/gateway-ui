`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

EditRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      isDirty = @currentModel?.get 'hasDirtyAttributes'
      isAllowedDirty = @currentModel?.get 'isAllowedDirty'
      isDeleted = @currentModel?.get 'isDeleted'
      if isDirty and !isAllowedDirty and !isDeleted
        if confirm t 'prompts.confirm-abandon'
          @currentModel?.cancel()
          true
        else
          transition.abort()

`export default EditRoute`
