`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

ApisRoute = Ember.Route.extend
  model: -> @store.find 'api'
  setupController: (controller, model) ->
    @_super controller, model
    controller.set 'breadCrumb', t('resources.api_plural')

`export default ApisRoute`
