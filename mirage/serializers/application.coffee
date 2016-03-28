`import { ActiveModelSerializer } from 'ember-cli-mirage'`

ApplicationSerializer = ActiveModelSerializer.extend
  keyForAttribute: (attr) -> attr
  keyForRelationship: (attr) -> attr

`export default ApplicationSerializer`
