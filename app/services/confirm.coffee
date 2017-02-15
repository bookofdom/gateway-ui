`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

ConfirmService = Ember.Service.extend
  open: (key) ->
    confirm t key

`export default ConfirmService`
