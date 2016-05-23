`import { Factory, faker } from 'ember-cli-mirage'`

names = 'order-123 order-456 order-789 order-012 order-345 order-678 order-901 order-234 order-567 order-890'.split ' '
nameCycle = faker.list.cycle names...

`export { nameCycle }`
