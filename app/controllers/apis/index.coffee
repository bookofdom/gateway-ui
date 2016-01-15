`import Ember from 'ember'`

ApisIndexController = Ember.Controller.extend
  actions:
    'export-api': (api) ->
      exportUrl = api.get 'exportUrl'
      window.open exportUrl, '_self'


`export default ApisIndexController`
