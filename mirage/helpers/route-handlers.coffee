`import { Response } from 'ember-cli-mirage'`

makePostHandler = (modelName) ->
  (schema, request) ->
    body = JSON.parse request.requestBody
    payload = body[modelName]
    if payload?.name is 'error'
      new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      schema[modelName.camelize()].create payload

makePutHandler = (modelName) ->
  (schema, request) ->
    id = request.params.id
    body = JSON.parse request.requestBody
    payload = body[modelName]
    if body[modelName]?.name is 'error'
      new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      updated = schema[modelName.camelize()].find(id).update payload

getParent = (schema, request, parentModelName) ->
  parentId = request.params["#{parentModelName.camelize()}Id"]
  schema[parentModelName.camelize()].find(parentId)

getChildren = (schema, request, parentModelName, modelName) ->
  parent = getParent schema, request, parentModelName
  parent[modelName.pluralize()]

makeGetChildrenHandler = (parentModelName, modelName) ->
  (schema, request) -> getChildren schema, request, parentModelName, modelName

makePostChildHandler = (parentModelName, modelName) ->
  (schema, request) ->
    parent = getParent schema, request, parentModelName
    body = JSON.parse request.requestBody
    payload = body[modelName]
    if payload?.name is 'error'
      new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      schema[modelName.camelize()].create payload, {"#{parentModelName.camelize()}Id": parent.id}

`export { makePostHandler, makePutHandler, makeGetChildrenHandler, makePostChildHandler }`
