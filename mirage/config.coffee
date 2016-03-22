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

  @get '/apis'
  @post '/apis'
  @get '/apis/:id'
  @put '/apis/:id'
  @del '/apis/:id'

`export default config`
