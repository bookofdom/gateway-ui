`import Ember from 'ember'`

ProxyEndpointRoutesIndexController = Ember.Controller.extend
  fields: [
    name: 'path'
    label: 'fields.path'
    type: 'string'
  ,
    name: 'get_method'
    label: 'http-methods.get'
    type: 'boolean'
  ,
    name: 'post_method'
    label: 'http-methods.post'
    type: 'boolean'
  ,
    name: 'put_method'
    label: 'http-methods.put'
    type: 'boolean'
  ,
    name: 'delete_method'
    label: 'http-methods.delete'
    type: 'boolean'
  ]

`export default ProxyEndpointRoutesIndexController`
