words = '''
request
response
AP.HTTP.Request
AP.HTTP.Response
method
uri
path
body
headers
form
query
vars
params
statusCode
body
headers
env
log
'''.split /\n/

initialize = (container, app) ->
  langTools = window.ace.require 'ace/ext/language_tools'
  completer =
    getCompletions: (editor, session, pos, prefix, callback) ->
      matches = []
      if prefix.length
        for word in words
          # high score for matches at the beginning of a word
          if word.toLowerCase().indexOf(prefix.toLowerCase()) == 0
            matches.push
              caption: word
              value: word
              meta: 'Gateway'
          # low score for matches at the beginning of a word
          else if word.toLowerCase().indexOf(prefix.toLowerCase()) > 0
            matches.push
              caption: word
              value: word
              meta: 'Gateway'
      callback null, matches
  langTools.addCompleter completer

AceInitializer =
  name: 'ace'
  initialize: initialize

`export {initialize}`
`export default AceInitializer`
