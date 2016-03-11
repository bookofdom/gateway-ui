`import Ember from 'ember'`


ApiDocumentationIndexRoute = Ember.Route.extend 
  onActivate: Ember.on 'activate', ->
    firstHost = @modelFor('api-documentation')?.get 'firstObject'
    if firstHost
      Ember.run.later (=>
        @transitionTo 'api-documentation-detail.index', firstHost
      ), 500

`export default ApiDocumentationIndexRoute`
