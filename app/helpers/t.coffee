`import Ember from 'ember'`
`import i18nHelper from './i18n'`

t = (args, options) ->
  value = args[0]
  i18nHelper value, options

THelper = Ember.Helper.helper t

`export { t }`

`export default THelper`