module.exports = function(app) {
  var express = require('express');
  var storeCollectionsRouter = express.Router();
  var storeCollections = [
    {
      id: 1,
      name: 'People'
    },
    {
      id: 2,
      name: 'Pets'
    }
  ];

  storeCollectionsRouter.get('/', function(req, res) {
    res.send({
      'store_collections': storeCollections
    });
  });

  storeCollectionsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.store_collection.id = id;
    res.status(201).send(body).end();
  });

  storeCollectionsRouter.get('/:id', function(req, res) {
    var storeCollection = storeCollections.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'store_collection': storeCollection[0]
    });
  });

  storeCollectionsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.store_collection.id = req.params.id;
    if (body.store_collection.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.store_collection.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  storeCollectionsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/store_collections', storeCollectionsRouter);
};
