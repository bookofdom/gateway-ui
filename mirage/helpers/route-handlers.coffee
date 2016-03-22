`import { Response } from 'ember-cli-mirage'`

makePostHandler = (modelName) ->
  (schema, request) ->
    body = JSON.parse request.requestBody
    if body[modelName]?.name is 'error'
      new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      schema[modelName].create body

makePutHandler = (modelName) ->
  (schema, request) ->
    id = request.params.id
    body = JSON.parse request.requestBody
    if body[modelName]?.name is 'error'
      new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      schema[modelName].find(id).update body

`export { makePostHandler, makePutHandler }`
