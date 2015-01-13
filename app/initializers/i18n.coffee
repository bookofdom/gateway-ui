`import Ember from 'ember'`
`import I18nHelper from '../helpers/i18n'`

I18nInitializer =
  name: 'i18n'
  initialize: (container, app) ->
    i18n.init
      getAsync: false
      detectLngQS: 'locale'
      fallbackLng: 'en'
    ,
      ->
        #locale = i18n.lng()
        #moment.locale locale
        Ember.Handlebars.registerBoundHelper 't', I18nHelper

`export default I18nInitializer`
