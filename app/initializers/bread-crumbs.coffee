BreadCrumbsInitializer =
  name: 'ember-breadcrumbs'
  initialize: (app) ->
    app.inject 'component:bread-crumbs', 'applicationController', 'controller:application'

`export default BreadCrumbsInitializer`
