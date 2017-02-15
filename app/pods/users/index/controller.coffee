`import Ember from 'ember'`

UsersIndexController = Ember.Controller.extend
  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ,
    name: 'email'
    type: 'string'
    label: 'fields.email'
  ,
    name: 'isAuthenticated'
    type: 'boolean'
    label: 'states.active'
  ,
    name: 'admin'
    type: 'boolean'
    label: 'fields.admin'
  ,
    name: 'confirmed'
    type: 'boolean'
    label: 'fields.confirmed'
  ]

`export default UsersIndexController`
