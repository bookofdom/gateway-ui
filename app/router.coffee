`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'component-reference', ->
    @route 'bootstrap'
  @route 'component-reference/anypresence'

`export default Router`
