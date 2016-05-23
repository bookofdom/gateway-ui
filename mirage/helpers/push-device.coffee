`import { Factory, faker } from 'ember-cli-mirage'`

names = 'customer-123 customer-456 customer-789 customer-012 customer-345 customer-678 customer-901 customer-234 customer-567 customer-890'.split ' '
nameCycle = faker.list.cycle names...

`export { nameCycle }`
