`import Ember from 'ember'`
`import BaseFormComponent from './base-form'`

ScratchPadFormComponent = BaseFormComponent.extend
  indexModel: null
  endpointType: null
  modelType: 'scratch-pad'

  fields: [
    name: 'name'
    required: true
  ,
    name: 'code'
    type: 'javascript'
  ]

  codeDefaults:
    http: 'request = new AP.HTTP.Request();'
    sqlserver: 'request = new AP.SQLServer.Request();'
    mysql: 'request = new AP.MySQL.Request();'
    postgres: 'request = new AP.Postgres.Request();'
    mongodb: 'request = new AP.Mongo.Request();'
    script: 'request = new AP.Script.Request();'
    soap: 'request = new AP.SOAP.Request();'

  modelObserver: Ember.observer 'model', ->
    model = @get 'model'
    if model?.get 'isNew'
      type = @get 'endpointType'
      model.set('code', @get('codeDefaults')[type])

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pads = @get 'indexModel'
      pads.pushObject model
    @_super.apply @, arguments

`export default ScratchPadFormComponent`
