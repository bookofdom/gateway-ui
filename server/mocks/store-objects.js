module.exports = function(app) {
  var express = require('express');
  var storeObjectsRouter = express.Router();
  var storeObjects = [
    {
        "id": 1,
        "store_collection_id": 1,
        "data": {"name": "John", "age": 21, "test": null, "foo": {"bar": true}, "baf": [1, 2, false, "test"]}
    },
    {
        "id": 2,
        "store_collection_id": 1,
        "data": {"name": "Jane", "age": 22, "foo": null}
    },
    {
        "id": 3,
        "store_collection_id": 1,
        "data": {"name": "Joe", "age": 23}
    },
    {
        "id": 4,
        "store_collection_id": 2,
        "data": {"name": "Lady", "breed": "border collie"}
    },
    {
        "id": 5,
        "store_collection_id": 2,
        "data": {"name": "Daisy", "breed": "golden retriever"}
    },
    {
        "id": 6,
        "store_collection_id": 2,
        "data": {"name": "Sally", "breed": "corgi"}
    }
  ];

  storeObjectsRouter.get('/:store_collection_id/store_objects', function(req, res) {
    var _storeObjects = storeObjects.filter(function (value) {
      return value.store_collection_id == req.params.store_collection_id;
    });
    res.send({
      'store_objects': _storeObjects
    });
  });

  storeObjectsRouter.post('/:store_collection_id/store_objects', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.store_object.id = id;
    res.status(201).send(body).end();
  });

  storeObjectsRouter.get('/:store_collection_id/store_objects/:id', function(req, res) {
    var storeObject = storeObjects.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'store_object': storeObject[0]
    });
  });

  storeObjectsRouter.put('/:store_collection_id/store_objects/:id', function(req, res) {
    var body = req.body;
    body.store_object.id = req.params.id;
    res.send(body);
  });

  storeObjectsRouter.delete('/:store_collection_id/store_objects/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/store_collections', storeObjectsRouter);
};
