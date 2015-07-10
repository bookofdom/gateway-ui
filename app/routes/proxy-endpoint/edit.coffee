`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointEditRoute = Ember.Route.extend AuthenticatedRouteMixin,
  actions:
    willTransition: (transition) ->
      if @currentModel.get('isDirty')
        if confirm(t('prompts.confirm-proxy-endpoint-leave').capitalize())
          @currentModel.reload()
        else
          transition.abort()
      return true

`export default ProxyEndpointEditRoute`
