`import Ember from 'ember'`

PushChannelMessagesRoute = Ember.Route.extend
  model: -> @store.findAll 'push-channel-message'
  renderTemplate: ->
    @_super arguments...
    @render 'push/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push-channel-messages'

`export default PushChannelMessagesRoute`
