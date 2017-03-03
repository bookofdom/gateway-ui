`import { Factory, faker } from 'ember-cli-mirage'`

HostFactory = Factory.extend
  name: -> faker.internet.domainWord().capitalize()
  hostname: -> faker.internet.domainName()
  force_ssl: -> true
  private_keY: -> 'data:text/plain;chatset=utf-8;base64,aGV5YQ=='
  cert: -> 'data:text/plain;chatset=utf-8;base64,aGV5YQ=='

`export default HostFactory`
