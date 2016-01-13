`import Ember from 'ember'`

I18nInitializer =
  name: 'i18n'
  initialize: (app) ->
    app.deferReadiness()
    i18n.init
      detectLngQS: 'locale'
      fallbackLng: 'en'
    ,
      ->
        locale = i18n.lng()
        moment.locale locale
        app.advanceReadiness()

`export default I18nInitializer`
