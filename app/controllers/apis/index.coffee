`import Ember from 'ember'`

ApisIndexController = Ember.ArrayController.extend
  'show-new-form': Ember.computed 'model.length', ->
    @get('model')
      .filterBy 'isNew', false
      .length
  actions:
    'export-api': (api) ->
      exportUrl = api.get 'exportUrl'
      window.open exportUrl, '_blank'
      

`export default ApisIndexController`
