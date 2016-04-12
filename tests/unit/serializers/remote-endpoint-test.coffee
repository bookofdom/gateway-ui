`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'remote-endpoint', 'Unit | Serializer | remote endpoint',
  needs: [
    'serializer:api'
    'serializer:environment'
    'serializer:remote-endpoint'
    'serializer:remote-endpoint-environment-datum'
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:remote-endpoint-environment-datum'
    'model:remote-endpoint-environment-datum-scratch-pad'
    'model:remote-endpoint-header'
    'model:remote-endpoint-host'
    'model:remote-endpoint-query-parameter'
    'model:shared-component'
  ]
  beforeEach: ->
    @server = new Pretender ->
      @get '/apis', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify apis: [
          id: 1
          name: 'Apples'
        ]
      ]
      @get '/apis/1/environments', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify environments: [
          api_id: 1
          id: 1
          name: 'One'
        ]
      ]
      @get '/apis/1/remote_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify remote_endpoints: [
        # http
          api_id: 1
          id: 1
          name: 'Alerts - GET'
          codename: 'alerts'
          description: ''
          type: 'http'
          status: null
          status_message: null
          data:
            url: 'http://justapis-mock.herokuapp.com/v1/alerts'
            query: {}
            method: 'GET'
            headers: {}
          environment_data: [
            remote_endpoint_id: 1
            environment_id: 1
            type: 'http'
            data:
              url: 'http://dev.test'
              query: {}
              method: 'GET'
              headers: {}
          ]
        , # http
          api_id: 1
          id: 2
          name: 'Event - DELETE'
          codename: 'deleteEvent'
          description: ''
          type: 'http'
          status: null
          status_message: null
          data:
            url: ''
            query: {}
            method: 'DELETE'
            headers:
              {}#Authorization: 'Basic YW55cHJlc2VuY2U6cGFzc3dvcmQ='
          environment_data: null
        , # ldap
          data:
            username: 'cn=barry.name, dc=sit, dc=com'
            password: 'iZnt71pDiPfihJZ'
            host: '32.203.82.167'
            port: 59838
            use_tls: false
            tls:
              server_name: 'zaria.net'
            headers: {}
              # quia: 'online'
            query: {}
              # cumque: 'online'
          type: 'ldap'
          environment_data: [
            type: 'ldap',
            data:
              username: 'cn=einar.org, dc=rerum, dc=com'
              password: 'xmyaSuQ8wFp1oqa'
              host: '13.182.25.10'
              port: 39485
              use_tls: true
              tls:
                server_name: 'jazmyn.name'
              headers: {}
                # assumenda: 'back-end'
              query: {}
                # dolor: 'haptic'
            environment_id: 1
            id: '19'
          ]
          status: 'processing'
          description: 'Sequi dolorum voluptates libero dolorem.'
          codename: 'sensor'
          name: 'Unbranded Plastic Hat'
          id: '7'
          api_id: '1'
        , # mongodb
          data:
            limit: 68475
            config:
              database: 'database'
              username: 'Karlee34'
              password: 'RPHz7x3SHEJX0Ib'
              hosts: []
              #   host: 'www.vicenta.info'
              #   port: 5112
            headers: {}
              # quod: 'redundant'
            query: {}
              # sit: 'haptic'
          type: 'mongodb'
          environment_data: [
            type: 'mongodb'
            data:
              limit: 55150
              config:
                database: 'database'
                username: 'Brannon20'
                password: 'n_Qavujq0gXiyvR'
                hosts: []
                  # host: 'www.edyth.name'
                  # port: 15178
              headers: {}
                # 'accusantium': 'auxiliary'
              query: {}
                # nobis: 'neural'
            environment_id: 1
            id: '16'
          ]
          status: 'pending'
          description: 'Aut velit molestiae rerum animi saepe architecto asperiores.'
          codename: 'matrix'
          name: 'Sleek Concrete Gloves'
          id: '6'
          api_id: '1'
        , # mysql
          data:
            config:
              server: 'server.marlen.org'
              port: 91768
              username: 'Clemmie_Ruecker63'
              password: '1RnK4wENvCDysv2'
              dbname: 'database'
            headers: {}
              # aperiam: 'haptic'
            query: {}
              # sunt: 'neural'
          type: 'mysql'
          environment_data: [
            type: 'mysql'
            data:
              config:
                server: 'server.christiana.biz'
                port: 24327
                username: 'Sally_Medhurst47'
                password: 'wNtMt_XnJFefm2F'
                dbname: 'database'
              headers: {}
                # ipsam: 'haptic'
              query: {}
                # quisquam: 'haptic'
            environment_id: 1
            id: '13'
          ]
          status: 'processing'
          description: 'Qui ut quisquam beatae rem.'
          codename: 'alarm'
          name: 'Practical Frozen Bacon'
          id: '5'
          api_id: '1'
        , # postgres
          data:
            transactions: true
            maxOpenConn: 35744
            maxIdleConn: 8553
            config:
              host: 'server.marcelo.net'
              port: 73872
              user: 'Kailey53'
              password: 'PUGUAd68YRc0et3'
              dbname: 'database'
              sslmode: 'allow'
            headers: {}
              # asperiores: 'haptic',
            query: {}
              # sapiente: 'bluetooth'
          type: 'postgres'
          environment_data: [
            type: 'postgres'
            data:
              transactions: true
              maxOpenConn: 47985
              maxIdleConn: 30802
              config:
                host: 'server.opal.com'
                port: 97836
                user: 'Wellington_Mraz17'
                password: 'hYth35ZaNatRova'
                dbname: 'database'
                sslmode: 'require'
              headers: {}
                # a: 'online'
              query: {}
                # voluptatem: 'open-source'
            environment_id: 1
            id: '10'
          ]
          status: 'failed'
          description: 'Qui nihil tempora saepe quo voluptas quam mollitia totam.'
          codename: 'card'
          name: 'Practical Metal Cheese'
          id: '4'
          api_id: '1'
        ]
      ]

    afterEach: ->
      @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('environments').then ->
      api.get('remote_endpoints').then (remote_endpoints) ->
        assert.equal remote_endpoints.get('length'), 6
