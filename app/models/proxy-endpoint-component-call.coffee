`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: true
  before: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  after: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component',
    inverse: null
    async: false
  
  reload: ->
    # delegate reload to parent proxy endpoint component
    @get('proxy_endpoint_component').reload()
  rollback: ->
    @get('before')?.forEach (record) -> record.rollback()
    @get('after')?.forEach (record) -> record.rollback()
    @_super.apply @, arguments
  save: ->
    # delegate save to parent proxy endpoint component and then
    # "rollback" to now-saved embedded record
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('proxy_endpoint_component').save().then (=>
        @rollback()
        resolve @
      ), (=> reject @)
  deleteRecord: ->
    @_super.apply @, arguments
    @get('proxy_endpoint_component.calls').removeObject @
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    component = @get 'proxy_endpoint_component'
    component.save().then (->
      component.rollback()
    ), (=>)

`export default ProxyEndpointComponentCall`
