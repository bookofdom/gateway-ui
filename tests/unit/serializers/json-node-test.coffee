`import { moduleForModel, test } from 'ember-qunit'`

testObject1 =
  boolAttr: true
  numAttr: 42
  strAttr: 'this is a string'
  objAttr:
    nestedObj:
      numAttr: 42
      nestedArr: [
        'string'
      ]
  arrAttr: [
    true
    42
    'string'
    {foo: 'bar'}
    [
      'nested array!'
    ]
  ]

moduleForModel 'json-node', 'Unit | Serializer | JsonNode',
  # Specify the other units that are required for this test.
  needs: ['serializer:json-node']

test 'it serializes records', (assert) ->
  record = @subject()
  serializedRecord = record.serialize()
  assert.ok serializedRecord

test 'it normalizes JSON to an array response', (assert) ->
  store = @store()
  serializer = store.serializerFor 'json-node'
  data = Ember.copy testObject1, true
  normalized = serializer.normalizeArrayResponse store, store.modelFor('json-node'), data

  expected =
    "data":[
      {
        "id":"17",
        "type":"json-node",
        "attributes":{
          "type":"object"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"1",
                "type":"json-node"
              },
              {
                "id":"2",
                "type":"json-node"
              },
              {
                "id":"3",
                "type":"json-node"
              },
              {
                "id":"8",
                "type":"json-node"
              },
              {
                "id":"16",
                "type":"json-node"
              }
            ]
          }
        }
      }
    ],
    "included":[
      {
        "id":"1",
        "type":"json-node",
        "attributes":{
          "type":"boolean",
          "name":"boolAttr",
          "value":"true"
        },
        "relationships":{

        }
      },
      {
        "id":"2",
        "type":"json-node",
        "attributes":{
          "type":"number",
          "name":"numAttr",
          "value":"42"
        },
        "relationships":{

        }
      },
      {
        "id":"3",
        "type":"json-node",
        "attributes":{
          "type":"string",
          "name":"strAttr",
          "value":"this is a string"
        },
        "relationships":{

        }
      },
      {
        "id":"8",
        "type":"json-node",
        "attributes":{
          "type":"object",
          "name":"objAttr"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"7",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"7",
        "type":"json-node",
        "attributes":{
          "type":"object",
          "name":"nestedObj"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"4",
                "type":"json-node"
              },
              {
                "id":"6",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"4",
        "type":"json-node",
        "attributes":{
          "type":"number",
          "name":"numAttr",
          "value":"42"
        },
        "relationships":{

        }
      },
      {
        "id":"6",
        "type":"json-node",
        "attributes":{
          "type":"object",
          "name":"nestedArr"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"5",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"5",
        "type":"json-node",
        "attributes":{
          "type":"string",
          "value":"string"
        },
        "relationships":{

        }
      },
      {
        "id":"16",
        "type":"json-node",
        "attributes":{
          "type":"object",
          "name":"arrAttr"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"9",
                "type":"json-node"
              },
              {
                "id":"10",
                "type":"json-node"
              },
              {
                "id":"11",
                "type":"json-node"
              },
              {
                "id":"13",
                "type":"json-node"
              },
              {
                "id":"15",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"9",
        "type":"json-node",
        "attributes":{
          "type":"boolean",
          "value":"true"
        },
        "relationships":{

        }
      },
      {
        "id":"10",
        "type":"json-node",
        "attributes":{
          "type":"number",
          "value":"42"
        },
        "relationships":{

        }
      },
      {
        "id":"11",
        "type":"json-node",
        "attributes":{
          "type":"string",
          "value":"string"
        },
        "relationships":{

        }
      },
      {
        "id":"13",
        "type":"json-node",
        "attributes":{
          "type":"object"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"12",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"12",
        "type":"json-node",
        "attributes":{
          "type":"string",
          "name":"foo",
          "value":"bar"
        },
        "relationships":{

        }
      },
      {
        "id":"15",
        "type":"json-node",
        "attributes":{
          "type":"object"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"14",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"14",
        "type":"json-node",
        "attributes":{
          "type":"string",
          "value":"nested array!"
        },
        "relationships":{

        }
      }
    ]

  assert.deepEqual normalized, expected
