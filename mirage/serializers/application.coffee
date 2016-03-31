`import { ActiveModelSerializer } from 'ember-cli-mirage'`

ApplicationSerializer = ActiveModelSerializer.extend
  keyForAttribute: (attr) -> attr
  keyForRelationship: (attr) -> attr
  serialize: ->
    serialized = ActiveModelSerializer.prototype.serialize.apply @, arguments
    # map relationshipId fields to relationship_id
    for key, value of serialized
      if key.match /Id$/
        serialized[key.underscore()] = value
    serialized

`export default ApplicationSerializer`
