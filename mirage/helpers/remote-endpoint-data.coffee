`import { Factory, faker } from 'ember-cli-mirage'`

enviromentDatumId = 1

types = 'http soap sqlserver postgres mysql mongodb ldap redis oracle script hana store push smtp db2 docker custom_function'.split ' '
typeCycle = faker.list.cycle types...

statuses = 'success failed pending processing'.split ' '
statusCycle = faker.list.random statuses...

methods = 'GET POST PUT DELETE'.split ' '
methodCycle = faker.list.random methods...

encryptModes = 'disable true false'.split ' '
encryptModeCycle = faker.list.random encryptModes...

sslModes = 'disable allow prefer require'.split ' '
sslModeCycle = faker.list.random sslModes...

platforms = 'osx ios gcm mqtt'.split ' '
platformCycle = faker.list.random platforms...

protocols = 'TCPIP SSL'.split ' '
protocolCycle = faker.list.random protocols...

generateKeyValues = (count) ->
  data = {}
  for i in [0..count]
    data[faker.lorem.words()[0]] = faker.hacker.adjective()
  data

generateDataForType = (typeSlug, i) ->
  data = switch typeSlug
    when 'http'
      url: "https://#{faker.internet.domainName()}"
      method: methodCycle i
    when 'soap'
      data =
        serviceName: faker.lorem.words().join('')
        url: "https://#{faker.internet.domainName()}"
      authSchemeKeyCycle = faker.list.random 'basicAuthCredentials', 'wssePasswordCredentials'
      data[authSchemeKeyCycle i] =
        username: faker.internet.userName()
        password: faker.internet.password()
      data
    when 'sqlserver'
      transactions: faker.random.boolean()
      maxOpenConn: faker.random.number()
      maxIdleConn: faker.random.number()
      config:
        server: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        'user id': faker.internet.userName()
        password: faker.internet.password()
        database: 'database'
        schema: 'schema'
        encrypt: encryptModeCycle i
        'connection timeout': faker.random.number()
    when 'postgres'
      transactions: faker.random.boolean()
      maxOpenConn: faker.random.number()
      maxIdleConn: faker.random.number()
      config:
        host: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        user: faker.internet.userName()
        password: faker.internet.password()
        dbname: 'database'
        sslmode: sslModeCycle i
    when 'mysql'
      config:
        server: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        username: faker.internet.userName()
        password: faker.internet.password()
        dbname: 'database'
    when 'mongodb'
      limit: faker.random.number()
      config:
        database: 'database'
        username: faker.internet.userName()
        password: faker.internet.password()
        hosts: [
          host: "www.#{faker.internet.domainName()}"
          port: faker.random.number()
        ,
          host: "www.#{faker.internet.domainName()}"
          port: faker.random.number()
        ]
    when 'ldap'
      username: "cn=#{faker.internet.domainName()}, dc=#{faker.lorem.words()[0]}, dc=com",
      password: faker.internet.password()
      host: "#{faker.random.number() % 256}.#{faker.random.number() % 256}.#{faker.random.number() % 256}.#{faker.random.number() % 256}"
      port: faker.random.number()
      use_tls: faker.random.boolean()
      tls:
        server_name: faker.internet.domainName()
    when 'script'
      config:
        interpreter: 'sh'
        timeout: 1 # seconds
        filepath: '/foo/bar/script.sh'
        script: 'echo "hello world"'
    when 'hana'
      transactions: faker.random.boolean()
      maxOpenConn: faker.random.number()
      maxIdleConn: faker.random.number()
      config:
        host: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        user: faker.internet.userName()
        password: faker.internet.password()
    when 'store'
      {}
    when 'push'
      publish_endpoint: faker.random.boolean()
      subscribe_endpoint: faker.random.boolean()
      unsubscribe_endpoint: faker.random.boolean()
    when 'redis'
      maxOpen: faker.random.number()
      maxIdle: faker.random.number()
      config:
        host: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        username: faker.internet.userName()
        password: faker.internet.password()
        database: '0'
    when 'oracle'
      transactions: faker.random.boolean()
      maxOpenConn: faker.random.number()
      maxIdleConn: faker.random.number()
      config:
        host: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        user: faker.internet.userName()
        password: faker.internet.password()
        dbname: 'database'
    when 'smtp'
      config:
        host: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        user: faker.internet.userName()
        password: faker.internet.password()
        sender: faker.internet.email()
    when 'db2'
      transactions: faker.random.boolean()
      config:
        dbname: 'database'
        host: "server.#{faker.internet.domainName()}"
        port: faker.random.number()
        protocol: protocolCycle i
        user: faker.internet.userName()
        password: faker.internet.password()
    when 'docker'
      repository: faker.commerce.productName().toLowerCase().underscore()
      tag: faker.random.number()
      command: 'my-command'
      arguments: [
        'arg1'
        'arg2'
      ]
      environment:
        FOO: 'bar'
        EXAMPLE_VAR: '42'
      username: faker.internet.userName()
      password: faker.internet.password()
      registry: faker.internet.domainName()
    when 'custom_function'
      {}
  data.headers = generateKeyValues 3
  data.query = generateKeyValues 3
  pushPlatformType = platformCycle i
  data.push_platforms = [
    name: faker.commerce.productName().capitalize()
    codename: "codename-for-#{pushPlatformType}-platform"
    type: pushPlatformType
    password: faker.internet.password()
    topic: faker.lorem.words().join('.')
    development: faker.random.boolean()
    api_key: faker.random.uuid()
    connect_timeout: faker.random.number() % 100
    ack_timeout: faker.random.number() % 100
    timeout_retries: faker.random.number() % 3
  ]
  data

`export { typeCycle, statusCycle, platformCycle, generateKeyValues, generateDataForType }`
