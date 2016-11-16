`import Ember from 'ember'`

AppVersionService = Ember.Service.extend Ember.Evented,
  store: Ember.inject.service 'store'
  pollingInterval: 5

  onInit: Ember.on 'init', ->
    @queuePoll()

  queuePoll: ->
    intervalMs = @get('pollingInterval') * 1000 # convert to ms
    Ember.run.debounce @, @checkAppVersion, intervalMs

  checkAppVersion: ->
    @get('store').findAll('info').then (allInfo) =>
      appInfo = allInfo.findBy 'id', 'app'
      if appInfo and appInfo.get 'isDifferentAppVersion'
        @trigger 'newRelease'
    @queuePoll()

`export default AppVersionService`
