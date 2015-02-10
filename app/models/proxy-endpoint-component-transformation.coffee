`import DS from 'ember-data'`

ProxyEndpointComponentTransformation = DS.Model.extend
  type: DS.attr 'string', defaultValue: 'js'
  body: DS.attr 'string'
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component', inverse: null
  toJSON: ->
    id: @get 'id'
    type: @get 'type'
    data: @get 'body'

`export default ProxyEndpointComponentTransformation`
