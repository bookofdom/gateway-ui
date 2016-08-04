`import Ember from 'ember'`

SecondaryView = Ember.View.extend
  layoutName: 'layouts/secondary'
  expanded: false
  showBreadCrumbs: true
  actions:
    toggleNav: ->
      expanded = @get 'expanded'
      @set 'expanded', !expanded

`export default SecondaryView`
