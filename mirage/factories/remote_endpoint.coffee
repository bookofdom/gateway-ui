`import { Factory, faker } from 'ember-cli-mirage'`

enviromentDatumId = 1

# TODO script type is missing from original mocks
#types = 'http soap sqlserver postgres mysql mongodb ldap script store'.split ' '
types = 'http soap sqlserver postgres mysql mongodb ldap store'.split ' '
typeCycle = faker.list.cycle types...

statuses = 'success failed pending processing'.split ' '
statusCycle = faker.list.random statuses...

methods = 'GET POST PUT DELETE'.split ' '
methodCycle = faker.list.random methods...

sslModes = 'disable allow prefer require'.split ' '
sslModeCycle = faker.list.random sslModes...

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
    when 'store'
      {}
  data.headers = generateKeyValues 3
  data.query = generateKeyValues 3
  data

generateEnvironmentDatumForType = (typeSlug, i) ->
  environmentDatum =
    id: enviromentDatumId++
    environment_id: faker.list.cycle(1, 2, 3, 4, 5)(i)
    data: generateDataForType typeSlug, i
  environmentDatum

generateRemoteEndpointForType = (typeSlug, i) ->
  generateDataForType typeSlug, i

RemoteEndpointFactory = Factory.extend
  name: -> faker.commerce.productName().capitalize()
  codename: -> faker.hacker.noun()
  description: -> faker.lorem.sentence()
  status: (i) -> statusCycle i
  type: (i) ->
    typeSlug = typeCycle i
    @data = generateRemoteEndpointForType typeSlug, i
    @environment_data = [
      generateEnvironmentDatumForType(typeSlug, i),
      generateEnvironmentDatumForType(typeSlug, i + 1),
      generateEnvironmentDatumForType(typeSlug, i + 2)
    ]
    typeSlug

`export default RemoteEndpointFactory`
