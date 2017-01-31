`import { Response } from 'ember-cli-mirage'`

makePostHandler = (modelName, callback) ->
  (schema, request) ->
    body = JSON.parse request.requestBody
    payload = body[modelName]
    if payload?.name is 'error'
      response = new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      response = schema[modelName.camelize()].create payload
    callback(schema[modelName.camelize()], request, response) if callback
    response

makePutHandler = (modelName, callback, key) ->
  (schema, request) ->
    id = request.params.id
    body = JSON.parse request.requestBody
    key ?= modelName
    payload = body[key]
    if payload?.name is 'error'
      response = new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      response = schema[modelName.camelize()].find(id).update payload
    callback(schema[modelName.camelize()].find(id), request, response) if callback
    response

getParent = (schema, request, parentModelName) ->
  parentId = request.params["#{parentModelName.camelize()}Id"]
  schema[parentModelName.camelize()].find(parentId)

getChildren = (schema, request, parentModelName, modelName) ->
  parent = getParent schema, request, parentModelName
  parent[modelName.pluralize()]

makeGetChildrenHandler = (parentModelName, modelName) ->
  (schema, request) -> getChildren schema, request, parentModelName, modelName

makePostChildHandler = (parentModelName, modelName, callback, key) ->
  (schema, request) ->
    parent = getParent schema, request, parentModelName
    body = JSON.parse request.requestBody
    key ?= modelName
    payload = body[key]
    if payload?.name is 'error'
      response = new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      data = Ember.merge payload,
        "#{parentModelName.camelize()}Id": parent.id
      response = schema[modelName.camelize()].create data
    callback(schema[modelName.camelize()], request, response) if callback
    response

`export { makePostHandler, makePutHandler, makeGetChildrenHandler, makePostChildHandler, getChildren }`
