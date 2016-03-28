`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

HostSerializer = ApplicationSerializer.extend
  attrs:
    api:
      serialize: false

`export default HostSerializer`
