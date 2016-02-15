`import Ember from 'ember'`
`import BaseFormComponent from './base-form'`

ScratchPadFormComponent = BaseFormComponent.extend
  indexModel: null
  endpointModel: null
  modelType: 'scratch-pad'

  fields: [
    name: 'name'
    required: true
  ,
    name: 'code'
    type: 'javascript'
  ]

  modelObserver: Ember.observer 'model', ->
    model = @get 'model'
    if model?.get 'isNew'
      type = @get 'endpointModel.type'
      switch type
        when 'http'
          model.set('code', 'request = new AP.HTTP.Request();')
        when 'sqlserver'
          model.set('code', 'request = new AP.SQLServer.Request();')
        when 'mysql'
          model.set('code', 'request = new AP.MySQL.Request();')
        when 'postgres'
          model.set('code', 'request = new AP.Postgres.Request();')
        when 'mongodb'
          model.set('code', 'request = new AP.Mongo.Request();')
        when 'script'
          model.set('code', 'request = new AP.Script.Request();')
        when 'soap'
          model.set('code', 'request = new AP.SOAP.Request();')

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pads = @get 'indexModel'
      pads.pushObject model
    @_super.apply @, arguments

`export default ScratchPadFormComponent`
