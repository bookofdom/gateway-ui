`import Ember from 'ember'`

ApiDocumentationDetailIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()
  'api-documentation': Ember.inject.controller()

  notify: Ember.inject.service()

  enableSwagger: Ember.computed.alias 'api.model.enable_swagger'
  showDocs: Ember.computed 'enableSwagger', 'api.model.hasDirtyAttributes', 'api.model.isSaving', ->
    enableSwagger = @get 'enableSwagger'
    dirty = @get 'api.model.hasDirtyAttributes'
    saving = @get 'api.model.isSaving'
    enableSwagger and !dirty and !saving

  actions:
    enableSwagger: ->
      model = @get 'api.model'
      notify = @get 'notify'
      model.set 'enable_swagger', true
      model.save().catch ->
        model.get('errors').forEach (error) ->
          notify.alert error.message

`export default ApiDocumentationDetailIndexController`
