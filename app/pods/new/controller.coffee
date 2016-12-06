`import Ember from 'ember'`

NewController = Ember.Controller.extend
  breadCrumb: 'actions.new'
  queryParams: ['next']

  actions:
    saved: ->
      next = @get 'next'
      if next == '-1'
        history.back()
      else
        @transitionToRoute 'environments'

`export default NewController`
