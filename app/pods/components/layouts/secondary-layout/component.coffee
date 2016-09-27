`import Ember from 'ember'`

LayoutsSecondaryLayoutComponent = Ember.Component.extend
  nav: 'navigations/secondary-nav'
  expanded: false
  showBreadCrumbs: true
  actions:
    toggleNav: ->
      expanded = @get 'expanded'
      @set 'expanded', !expanded

`export default LayoutsSecondaryLayoutComponent`
