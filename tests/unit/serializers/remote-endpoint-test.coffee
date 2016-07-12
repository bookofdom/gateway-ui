`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'remote-endpoint', 'Unit | Serializer | remote endpoint',
  needs: [
    'serializer:application'
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
    'model:remote-endpoint-push-platform'
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
          id: 3
          api_id: 1
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
          id: 4
          api_id: 1
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
          id: 5
          api_id: 1
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
          id: 6
          api_id: 1
        , # script
          type: 'script'
          name: 'Practical Metal Cheese'
          codename: 'pcm'
          description: 'Practical Metal Cheese'
          sslmode: 'prefer'
          timeout: 30
          use_tls: false
          interpreter: 'sh'
          filepath: '/~'
          script: 'echo ~'
          environment_data: []
          data:
            headers: {}
            query: {}
            config:
              interpreter: 'sh'
              timeout: 30
              filepath: '/~'
              script: 'echo ~'
          id: 7
          api_id: 1
        , # store
          data:
            headers: {}
              # deleniti: 'solid state'
            query: {}
              # nostrum: 'virtual'
          type: 'store'
          environment_data: [
            type: 'store'
            data:
              headers: {}
                # deleniti: 'solid state'
              query: {}
                # nostrum: 'virtual'
            environment_id: 1
            id: '22'
          ]
          status: 'failed'
          description: 'Consequatur non ullam quidem sed laborum aut.'
          codename: 'card'
          name: 'Sleek Steel Pizza'
          id: 8
          api_id: 1
        , # soap
          data:
            serviceName: 'laudantiumvoluptatesplaceat'
            url: 'https://lincoln.org'
            wssePasswordCredentials:
              username: 'Destin.Moen'
              password: 'NIJJC_avWSFiRIJ'
            headers: {}
              # tempore: 'optical'
            query: {}
              # sed: '1080p'
          type: 'soap'
          environment_data: [
            type: 'soap'
            data:
              serviceName: 'iureesseet'
              url: 'https://brandt.net'
              wssePasswordCredentials:
                username: 'Wilma89'
                password: 'BRjC8ZmqEmDObji'
              headers: {}
                # neque: 'solid state'
              query: {}
                # maxime: 'cross-platform'
            environment_id: 1
            id: '4'
          ]
          status: 'failed'
          description: 'Iste doloribus quia.'
          codename: 'transmitter'
          name: 'Tasty Soft Shirt'
          id: 9
          api_id: 1
        , # sqlserver
          data:
            transactions: false
            maxOpenConn: 28460
            maxIdleConn: 19879
            config:
              server: 'server.jaquan.com'
              port: 91763
              'user id': 'Hilda_Dooley'
              password: 'W8SorC6vv0LatS8'
              database: 'database'
              schema: 'schema'
              'connection timeout': 77921
            headers: {}
              # cumque: 'back-end'
            query: {}
              # inventore: 'bluetooth'
          type: 'sqlserver'
          environment_data: [
            type: 'sqlserver'
            data:
              transactions: false
              maxOpenConn: 31182
              maxIdleConn: 24684
              config:
                server: 'server.ana.com'
                port: 3427
                'user id': 'Novella40'
                password: 'UD3CxZeKTMcJ9xi'
                database: 'database'
                schema: 'schema'
                'connection timeout': 49686
              headers: {}
                # sunt: 'mobile'
              query: {}
                # nesciunt: 'haptic'
            environment_id: 1
            id: '7'
          ]
          status: 'processing'
          description: 'Accusamus rem aperiam perferendis.'
          codename: 'feed'
          name: 'Rustic Fresh Mouse'
          id: 10
          api_id: '1'
        , # push
          api_id: '1'
          id: 11
          name: "Test"
          codename: "test"
          description: ""
          type: 'push'
          status: null
          status_message: null
          data:
            headers: {}
            query: {}
            push_platforms: [
              name: "test"
              codename: "test"
              type: "osx"
              certificate: "data:application/x-pkcs12;base64,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"
              development: false
            ,
              name: 'test-gcm'
              codename: 'test-gcm'
              platform_type: 'gcm'
              development: false
              api_key: 'AIzaSyCPc6PN7PkKT7BGj-b60XAmEpp6f9N1oNY'
            ]
            publish_endpoint: true
          environment_data: [
            id: 8
            environment_id: 1
            type: "push"
            data:
              headers: {}
              query: {}
              push_platforms: [
                name: "gcm"
                codename: "gcm"
                type: "gcm"
                development: false
                api_key: "AIzaSyCPc6PN7PkKT7BGj-b60XAmEpp6f9N1oNY"
              ]
              publish_endpoint: false
          ]
          , # smtp
            api_id: '1'
            id: 12
            name: 'Gmail smtp',
            codename: 'gmail'
            description: ''
            type: 'smtp'
            status: 'failed'
            data:
              config:
                host: 'smtp.gmail.com'
                port: 587
                username: 'user'
                password: 'password'
                sender: 'user@gmail.com'
            environment_data: null
          , # redis
            api_id: '1'
            id: 13
            name: 'redis',
            codename: 'redis'
            description: ''
            type: 'redis'
            status: 'failed'
            data:
              config:
                host: 'localhost'
                port: 6379
                username: 'user'
                password: 'password'
                database: '0'
              maxidle: 5
              maxopen: 5
            environment_data: null
        ]
      ]

    afterEach: ->
      @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('environments').then ->
      api.get('remote_endpoints').then (remote_endpoints) ->
        assert.equal remote_endpoints.get('length'), 12
