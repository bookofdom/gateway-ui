`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointTestQueryParameter = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @

`export default ProxyEndpointTestQueryParameter`
