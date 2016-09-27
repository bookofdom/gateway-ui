`import Ember from 'ember'`

LayoutsSecondaryLayoutComponent = Ember.Component.extend
  sidebar: 'sidebars/secondary-sidebar'
  expanded: false
  showBreadCrumbs: true
  actions:
    toggleNav: ->
      expanded = @get 'expanded'
      @set 'expanded', !expanded

`export default LayoutsSecondaryLayoutComponent`
