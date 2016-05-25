`import Ember from 'ember'`

EmberParallelInitializer =
  name: 'ember-parallel'
  initialize: (app) ->
    # Ember Parallel's default handling of JSON stringification is wrong.
    # For example, it converts strings to undefineds.
    # We attempt to fix that here.
    Ember.JSONify = (obj) ->
      if obj?.toJSON
        obj.toJSON()
      else if obj?.toArray
        obj.toArray().map (d) ->
          if (d and d.toJSON) then d.toJSON() else d
      else
        obj

`export default EmberParallelInitializer`
