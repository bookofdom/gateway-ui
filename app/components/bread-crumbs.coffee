`import Ember from 'ember'`

BreadCrumbsComponent = Ember.Component.extend
  router: null
  applicationController: null
  handlerInfos: Ember.computed 'applicationController.currentPath', ->
    @get('router').router.currentHandlerInfos
  ###
  For the pathNames and controllers properties, we must be careful not to NOT
  specify the properties of the route in our dependent keys.

  Observing the controller property of the route causes some serious problems:
  https://github.com/chrisfarber/ember-breadcrumbs/issues/21
  ###
  pathNames: Ember.computed 'handlerInfos.[]', ->
    @get('handlerInfos').map (handlerInfo) ->
      handlerInfo.name
  controllers: Ember.computed 'handlerInfos.[]', ->
    @get('handlerInfos').map (handlerInfo) ->
      handlerInfo.handler.controller
  breadCrumbs: Ember.computed 'controllers.@each.breadCrumbs', 'controllers.@each.breadCrumb', 'controllers.@each.breadCrumbPath', 'controllers.@each.breadCrumbModel', 'pathNames.[]', ->
    controllers = @get 'controllers'
    defaultPaths = @get 'pathNames'
    breadCrumbs = Ember.A []
    controllers.forEach (controller, index) ->
      crumbs = controller.get('breadCrumbs') or Ember.A([])
      singleCrumb = controller.get 'breadCrumb'
      if !Ember.isBlank singleCrumb
        crumbs.push
          label: singleCrumb
          secondaryLabel: controller.get 'breadCrumbSecondary'
          path: controller.get 'breadCrumbPath'
          model: controller.get 'breadCrumbModel'
      crumbs.forEach (crumb) ->
        breadCrumbs.addObject Ember.Object.create
          label: crumb.label
          secondaryLabel: crumb.secondaryLabel
          path: crumb.path or defaultPaths[index]
          model: crumb.model
          linkable: if !Ember.isNone(crumb.linkable) then crumb.linkable else true
          isCurrent: false
    deepestCrumb = Ember.get breadCrumbs, 'lastObject'
    if deepestCrumb
      deepestCrumb.isCurrent = true
    breadCrumbs

`export default BreadCrumbsComponent`
