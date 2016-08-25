`import Ember from 'ember'`

alreadyRun = false

ParentRouteInitializer =
  name: 'parent-route'
  initialize: ->
    if alreadyRun
      return
    else
      alreadyRun = true
    Ember.Route.reopen
      parentRoute: Ember.computed ->
        r = @router.router;
        if r.activeTransition
          handlerInfos = r.activeTransition.state.handlerInfos
        else
          handlerInfos = r.state.handlerInfos
        return if !handlerInfos
        parent = @
        found = false
        handlerInfos.forEach (info) =>
          found = true if info.handler == @
          parent = info.handler if !found
        parent

      parentRouteName: Ember.computed.alias 'parentRoute.routeName'
      parentController: Ember.computed -> @controllerFor @get('parentRouteName')
      parentModel: Ember.computed -> @modelFor @get('parentRouteName')

`export default ParentRouteInitializer`
