`import Ember from 'ember'`

ReplController = Ember.Controller.extend
  breadCrumb: 'resources.repl'
  queryParams: ['environment']

`export default ReplController`
