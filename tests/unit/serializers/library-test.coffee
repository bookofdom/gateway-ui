`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

server = null

moduleForModel 'library', 'Unit | Serializer | library', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:library'
    'model:api'
  ]

  beforeEach: ->
    server = new Pretender (->
      @get '/apis', ->
        response = {
          "libraries": [
            {
                "api_id": 260,
                "id": 217,
                "name": "Authentication Credentials",
                "description": "",
                "data": "var mock_authorization = \"Basic YW55cHJlc2VuY2U6cGFzc3dvcmQ=\";\n"
            },
            {
                "api_id": 260,
                "id": 218,
                "name": "Data Variables",
                "description": "These are variables that hold static data.",
                "data": "var news_response_data = [\n  {\n      \"alert_date\": \"2014-09-05\",\n      \"created_at\": \"2014-09-05T15:12:16Z\",\n      \"description\": \"Mark Kent made FORTUNE magazine's list of the top 50 business leaders of 2011, coming in at No. 9. FORTUNE had this to say about our Company's Chairman and CEO: \\\"Under his leadership, the company has invested heavily in emerging markets like China, India and Mexico, where rapid urbanization, population growth and rising per capita income are driving demand\\\".\",\n      \"id\": 31,\n      \"image_url\": \"http://anypresence-demo-data.s3.amazonaws.com/generic/images/award_image.png\",\n      \"title\": \"FORTUNE Recognizes Mark Kent\",\n      \"updated_at\": \"2014-09-05T15:12:16Z\"\n  }];"
            }
          ]
        }
        return [
          200
          {"Content-Type": "application/json"}
          JSON.stringify response
        ]
    )

  afterEach: ->
    server.shutdown()

}

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
