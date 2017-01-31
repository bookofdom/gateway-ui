I18nHelper = (value, options) ->
  i18next.t(value, options)?.capitalize()

`export default I18nHelper`
