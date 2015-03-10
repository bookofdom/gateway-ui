`import Ember from 'ember'`
`import config from '../config/environment'`

initialize = ->
  config.meta ?= {}
  Ember.$('head meta').each (i, el) ->
    name = Ember.$(el).attr 'name'
    content = Ember.$(el).attr 'content'
    config.meta[name] = content if name and content

MetaConfigInitializer =
  name: 'meta-config'
  before: 'simple-auth'
  initialize: initialize

`export {initialize}`
`export default MetaConfigInitializer`
