`import I18nHelper from 'gateway/helpers/i18n'`

module 'I18nHelper'

# Replace this with your real tests.
test 'it works', ->
  result = I18nHelper 'test'
  equal result, ''

# TODO
# how to unit test i18n?
# translations are loaded via AJAX, thus not generally available to unit tests
