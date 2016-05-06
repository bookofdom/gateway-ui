`import { Factory, faker } from 'ember-cli-mirage'`

enviromentDatumId = 1

types = 'http soap sqlserver postgres mysql mongodb ldap script store'.split ' '
typeCycle = faker.list.cycle types...

statuses = 'success failed pending processing'.split ' '
statusCycle = faker.list.random statuses...

methods = 'GET POST PUT DELETE'.split ' '
methodCycle = faker.list.random methods...

encryptModes = 'disable true false'.split ' '
encryptModeCycle = faker.list.random encryptModes...

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
    when 'store'
      {}
  data.headers = generateKeyValues 3
  data.query = generateKeyValues 3
  data

`export { typeCycle, statusCycle, generateKeyValues, generateDataForType }`
