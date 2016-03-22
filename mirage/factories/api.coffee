`import { Factory, faker } from 'ember-cli-mirage'`

ApiFactory = Factory.extend
  name: (i) -> faker.commerce.productName()
  base_url: (i) -> "http://www.#{faker.internet.domainName()}"
  description: (i) -> faker.lorem.paragraph()

`export default ApiFactory`
