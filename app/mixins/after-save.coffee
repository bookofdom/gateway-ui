`import Ember from 'ember'`

AfterSaveMixin = Ember.Mixin.create
  save: ->
    @_super.apply(@, arguments).then (value) =>
      @trigger 'afterSave'
      value

`export default AfterSaveMixin`
