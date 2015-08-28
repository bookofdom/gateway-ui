`import Ember from 'ember'`

LifecycleHooksMixin = Ember.Mixin.create
  onSave: Ember.on 'didCreate', 'didUpdate', ->
    @trigger 'didSave'

  reload: ->
    @_super.apply(@, arguments).then (value) =>
      @trigger 'didReload'
      value

  rollback: ->
    @_super.apply @, arguments
    @trigger 'didRollback'

  rollbackAttributes: ->
    @_super.apply @, arguments
    @trigger 'didRollbackAttributes'

`export default LifecycleHooksMixin`
