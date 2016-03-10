`import Ember from 'ember'`


ApiDocumentationRoute = Ember.Route.extend 
  model: -> @modelFor('api').get 'hosts'

`export default ApiDocumentationRoute`
