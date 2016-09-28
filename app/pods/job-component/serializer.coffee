`import ActionComponentSerializer from 'gateway/pods/action-component/serializer'`

JobComponentSerializer = ActionComponentSerializer.extend
  attrs:
    job:
      serialize: false
    shared_component:
      serialize: 'id'
    calls:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'

`export default JobComponentSerializer`
