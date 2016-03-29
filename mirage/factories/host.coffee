`import { Factory, faker } from 'ember-cli-mirage'`

HostFactory = Factory.extend
  name: -> faker.internet.domainWord().capitalize()
  hostname: -> faker.internet.domainName()

`export default HostFactory`
