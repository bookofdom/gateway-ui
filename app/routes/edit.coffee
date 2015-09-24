`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

EditRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      isDirty = @currentModel.get 'hasDirtyAttributes'
      isDeleted = @currentModel.get 'isDeleted'
      if isDirty and !isDeleted
        if confirm t 'prompts.confirm-abandon'
          @currentModel.cancel()
          true
        else
          transition.abort()

`export default EditRoute`
