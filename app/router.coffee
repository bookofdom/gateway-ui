`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # development helpers
  @route 'component-reference', ->
    @route 'bootstrap'
    @route 'anypresence'
  
  # resources
  @resource 'api', (->)

`export default Router`
