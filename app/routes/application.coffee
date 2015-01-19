`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
  renderTemplate: ->
    @render()
    @render 'application/header',
      into: 'application'
      outlet: 'header'

`export default ApplicationRoute`
