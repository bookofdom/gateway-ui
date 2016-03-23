`import { Response } from 'ember-cli-mirage'`
`import { makePostHandler, makePutHandler } from './helpers/route-handlers'`

config = ->
  ###
  Config (with defaults).

  Note: these only affect routes defined *after* them!
  ###

  @passthrough()

  # @urlPrefix = '';    # make this `http://localhost:8080`, for example, if your API is on a different server
  @namespace = 'admin';    # make this `api`, for example, if your API is namespaced
  # @timing = 400;      # delay for each request, automatically set to 0 during testing

  ###
  Shorthand cheatsheet:

  @get('/posts')
  @post('/posts')
  @get('/posts/:id')
  @put('/posts/:id') # or @patch
  @del('/posts/:id')
  ###

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

  @get '/apis'
  @post '/apis', makePostHandler 'api'
  @get '/apis/:id'
  @put '/apis/:id', makePutHandler 'api'
  @del '/apis/:id'

  @get '/users'
  @post '/users', makePostHandler 'user'
  @get '/users/:id'
  @put '/users/:id', makePutHandler 'user'
  @del '/users/:id'

  @get '/store_collections'
  @post '/store_collections', makePostHandler 'store_collection'
  @get '/store_collections/:id'
  @put '/store_collections/:id', makePutHandler 'store_collection'
  @del '/store_collections/:id'

`export default config`
