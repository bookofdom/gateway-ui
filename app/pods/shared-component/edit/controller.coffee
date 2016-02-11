`import EditController from 'gateway/controllers/edit'`

SharedComponentEditController = EditController.extend
  'api': Ember.inject.controller()

  'option-groups': Ember.computed 'api.libraries', ->
    conditional: @get 'api.libraries'
    body: @get 'api.libraries'

`export default SharedComponentEditController`
