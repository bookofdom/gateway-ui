`import Ember from 'ember'`

LifecycleHooksMixin = Ember.Mixin.create
  onSave: Ember.on 'didCreate', 'didUpdate', ->
    @trigger 'didSave'

  reload: ->
    @_super(arguments...).then (value) =>
      @trigger 'didReload'
      value

  rollback: ->
    @_super arguments...
    @rollbackAttributes()
    @trigger 'didRollback'

  rollbackAttributes: ->
    @_super arguments...
    @trigger 'didRollbackAttributes'

`export default LifecycleHooksMixin`
