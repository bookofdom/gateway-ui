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

  # password resets are dumb endpoints
  @post '/password_reset', -> new Response 200
  @post '/password_reset_confirmation', -> new Response 200

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

  @get '/apis/:apiId/libraries', makeGetChildrenHandler('api', 'library')
  @post '/apis/:apiId/libraries', makePostChildHandler('api', 'library')
  @get '/apis/:apiId/libraries/:id'
  @put '/apis/:apiId/libraries/:id', makePutHandler 'library'
  @del '/apis/:apiId/libraries/:id'

  @get '/apis/:apiId/hosts', makeGetChildrenHandler('api', 'host')
  @post '/apis/:apiId/hosts', makePostChildHandler('api', 'host')
  @get '/apis/:apiId/hosts/:id'
  @put '/apis/:apiId/hosts/:id', makePutHandler 'host'
  @del '/apis/:apiId/hosts/:id'

  @get '/apis/:apiId/endpoint_groups', makeGetChildrenHandler('api', 'endpoint_group')
  @post '/apis/:apiId/endpoint_groups', makePostChildHandler('api', 'endpoint_group')
  @get '/apis/:apiId/endpoint_groups/:id'
  @put '/apis/:apiId/endpoint_groups/:id', makePutHandler 'endpoint_group'
  @del '/apis/:apiId/endpoint_groups/:id'

`export default config`
