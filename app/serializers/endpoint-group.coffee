`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

EndpointGroupSerializer = ApplicationSerializer.extend
  attrs:
    api:
      serialize: false

`export default EndpointGroupSerializer`
