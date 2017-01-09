`import ApplicationSerializer from 'gateway-ui/mirage/serializers/application'`

LogSerializer = ApplicationSerializer.extend
  root: false
  embed: true
  attrs: ['logs']

`export default LogSerializer`
