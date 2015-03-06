`import Ember from 'ember'`

ApisIndexController = Ember.ArrayController.extend
  'help-url': 'http://docs.anypresence.com'
  actions:
    'export-api': (api) ->
      exportUrl = api.get 'exportUrl'
      window.open exportUrl, '_blank'
      

`export default ApisIndexController`
