`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

EditRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      if @currentModel.get 'hasDirtyAttributes'
        if confirm t 'prompts.confirm-abandon'
          # TODO
          # This duplicates the cancel functionality of ap model form.
          # This should be moved up into a route method and reused by
          # both the form and this route.
          @currentModel.rollback()
          @currentModel.reload().then =>
            @currentModel.rollback()
          true
        else
          transition.abort()

`export default EditRoute`
