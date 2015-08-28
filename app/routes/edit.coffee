`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

EditRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      if @currentModel.get 'hasDirtyAttributes'
        if confirm t 'prompts.confirm-abandon'
          @currentModel.cancel()
          true
        else
          transition.abort()

`export default EditRoute`
