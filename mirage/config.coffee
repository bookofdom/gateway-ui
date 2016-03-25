`import { Response } from 'ember-cli-mirage'`
`import { makePostHandler, makePutHandler, makeGetChildrenHandler, makePostChildHandler } from './helpers/route-handlers'`

config = ->
  @passthrough()

  # @urlPrefix = '';    # make this `http://localhost:8080`, for example, if your API is on a different server
  @namespace = 'admin';    # make this `api`, for example, if your API is namespaced
  # @timing = 400;      # delay for each request, automatically set to 0 during testing

  @post '/sessions', (schema, request) ->
    body = JSON.parse request.requestBody
    sessions = schema.session.where
      email: body.email
      password: body.password
    session = sessions[0]
    if !session
      new Response 400, {}, error: 'Login failed.'
    else
      session

  # registrations is a dumb endpoint... it just returns the posted payload
  @post '/registrations', (schema, request) -> JSON.parse request.requestBody

  @get '/store_collections'
  @post '/store_collections', makePostHandler 'store_collection'
  @get '/store_collections/:id'
  @put '/store_collections/:id', makePutHandler 'store_collection'
  @del '/store_collections/:id'

  @get '/store_collections/:storeCollectionId/store_objects', makeGetChildrenHandler('store_collection', 'store_object')
  @post '/store_collections/:storeCollectionId/store_objects', makePostChildHandler('store_collection', 'store_object')
  @get '/store_collections/:storeCollectionId/store_objects/:id'
  @put '/store_collections/:storeCollectionId/store_objects/:id', makePutHandler 'store_object'
  @del '/store_collections/:storeCollectionId/store_objects/:id'

  @get '/users'
  @post '/users', makePostHandler 'user'
  @get '/users/:id'
  @put '/users/:id', makePutHandler 'user'
  @del '/users/:id'

  @get '/apis'
  @post '/apis', makePostHandler 'api'
  @get '/apis/:id'
  @put '/apis/:id', makePutHandler 'api'
  @del '/apis/:id'

`export default config`
