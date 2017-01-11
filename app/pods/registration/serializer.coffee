`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

RegistrationSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin

`export default RegistrationSerializer`
