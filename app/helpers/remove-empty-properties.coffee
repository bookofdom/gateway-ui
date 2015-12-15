RemoveEmptyPropertiesHelper = (obj, options) ->
  newObj = {}
  for key, value of obj
    newObj[key] = value if !Ember.isEmpty value
  newObj

`export default RemoveEmptyPropertiesHelper`
