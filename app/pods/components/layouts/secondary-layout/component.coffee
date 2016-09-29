`import Ember from 'ember'`

LayoutsSecondaryLayoutComponent = Ember.Component.extend
  nav: 'navigations/secondary-nav'
  data: null
  expanded: false
  showBreadCrumbs: true
  actions:
    toggleNav: ->
      expanded = @get 'expanded'
      @set 'expanded', !expanded

`export default LayoutsSecondaryLayoutComponent`
