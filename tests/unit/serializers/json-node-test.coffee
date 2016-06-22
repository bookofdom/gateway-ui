`import { moduleForModel, test } from 'ember-qunit'`

testObject1 =
  boolAttr: true
  numAttr: 42
  strAttr: 'this is a string'
  nullAttr: null
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
    null
    {foo: 'bar'}
    [
      'nested array!'
    ]
  ]

moduleForModel 'json-node', 'Unit | Serializer | JsonNode',
  # Specify the other units that are required for this test.
  needs: ['serializer:json-node']

test 'it normalizes JSON to an array response', (assert) ->
  store = @store()
  serializer = store.serializerFor 'json-node'
  data = Ember.copy testObject1, true
  normalized = serializer.normalizeArrayResponse store, store.modelFor('json-node'), data

  expected =
    "data":[
      {
        "id":"19",
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
                "id":"4",
                "type":"json-node"
              },
              {
                "id":"9",
                "type":"json-node"
              },
              {
                "id":"18",
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
        "id":"4",
        "type":"json-node",
        "attributes":{
          "type":"null",
          "name":"nullAttr"
        },
        "relationships":{

        }
      },
      {
        "id":"9",
        "type":"json-node",
        "attributes":{
          "type":"object",
          "name":"objAttr"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"8",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"8",
        "type":"json-node",
        "attributes":{
          "type":"object",
          "name":"nestedObj"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"5",
                "type":"json-node"
              },
              {
                "id":"7",
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
          "type":"number",
          "name":"numAttr",
          "value":"42"
        },
        "relationships":{

        }
      },
      {
        "id":"7",
        "type":"json-node",
        "attributes":{
          "type":"array",
          "name":"nestedArr"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"6",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"6",
        "type":"json-node",
        "attributes":{
          "type":"string",
          "value":"string"
        },
        "relationships":{

        }
      },
      {
        "id":"18",
        "type":"json-node",
        "attributes":{
          "type":"array",
          "name":"arrAttr"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"10",
                "type":"json-node"
              },
              {
                "id":"11",
                "type":"json-node"
              },
              {
                "id":"12",
                "type":"json-node"
              },
              {
                "id":"13",
                "type":"json-node"
              },
              {
                "id":"15",
                "type":"json-node"
              },
              {
                "id":"17",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"10",
        "type":"json-node",
        "attributes":{
          "type":"boolean",
          "value":"true"
        },
        "relationships":{

        }
      },
      {
        "id":"11",
        "type":"json-node",
        "attributes":{
          "type":"number",
          "value":"42"
        },
        "relationships":{

        }
      },
      {
        "id":"12",
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
          "type":"null"
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
          "name":"foo",
          "value":"bar"
        },
        "relationships":{

        }
      },
      {
        "id":"17",
        "type":"json-node",
        "attributes":{
          "type":"array"
        },
        "relationships":{
          "children":{
            "data":[
              {
                "id":"16",
                "type":"json-node"
              }
            ]
          }
        }
      },
      {
        "id":"16",
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

test 'it serializes a JSON node', (assert) ->
  store = @store()
  Ember.run ->
    record = store.createRecord 'json-node',
      type: 'object'
      children: [
        store.createRecord 'json-node',
          type: 'boolean'
          name: 'boolAttr'
          value: 'true'
        store.createRecord 'json-node',
          type: 'number'
          name: 'numAttr'
          value: '42'
        store.createRecord 'json-node',
          type: 'string'
          name: 'strAttr'
          value: 'this is a string'
        store.createRecord 'json-node',
          type: 'null'
          name: 'nullAttr'
        store.createRecord 'json-node',
          type: 'object'
          name: 'objAttr'
          children: [
            store.createRecord 'json-node',
              type: 'object'
              name: 'nestedObj'
              children: [
                store.createRecord 'json-node',
                  type: 'number'
                  name: 'numAttr'
                  value: '42'
                store.createRecord 'json-node',
                  type: 'array'
                  name: 'nestedArr'
                  children: [
                    store.createRecord 'json-node',
                      type: 'string'
                      value: 'string'
                  ]
              ]
          ]
        store.createRecord 'json-node',
          type: 'array'
          name: 'arrAttr'
          children: [
            store.createRecord 'json-node',
              type: 'boolean'
              value: 'true'
            store.createRecord 'json-node',
              type: 'number'
              value: '42'
            store.createRecord 'json-node',
              type: 'string'
              value: 'string'
            store.createRecord 'json-node',
              type: 'null'
            store.createRecord 'json-node',
              type: 'object'
              children: [
                store.createRecord 'json-node',
                  type: 'string'
                  name: 'foo'
                  value: 'bar'
              ]
            store.createRecord 'json-node',
              type: 'array'
              children: [
                store.createRecord 'json-node',
                  type: 'string'
                  value: 'nested array!'
              ]
          ]
      ]

    serialized = record.serialize()
    assert.deepEqual serialized, testObject1
