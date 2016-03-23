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

getChildren = (schema, request, parentModelName, modelName) ->
  parentId = request.params["#{parentModelName.camelize()}Id"]
  schema[parentModelName.camelize()].find(parentId)[modelName.pluralize()]

makeGetChildrenHandler = (parentModelName, modelName) ->
  (schema, request) -> getChildren schema, request, parentModelName, modelName

`export { makePostHandler, makePutHandler, makeGetChildrenHandler }`
