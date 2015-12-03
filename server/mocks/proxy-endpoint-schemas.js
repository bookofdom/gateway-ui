module.exports = function(app) {
  var express = require('express');
  var schemasRouter = express.Router();
  var schemas = [
    {
        "proxy_endpoint_id": 1,
        "id": 1,
        "name": "Schema 1"
    },
    {
        "proxy_endpoint_id": 2,
        "id": 2,
        "name": "Schema 2"
    }
  ];

  schemasRouter.get('/:proxy_endpoint_id/schemas/', function(req, res) {
    var _schemas = schemas.filter(function (value) {
      return value.proxy_endpoint_id == req.params.proxy_endpoint_id;
    });
    res.send({
      'proxy-endpoint-schemas': _schemas
    });
  });

  schemasRouter.post('/:proxy_endpoint_id/schemas/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.proxy_endpoint_schema.id = id;
    res.status(201).send(body).end();
  });

  schemasRouter.get('/:proxy_endpoint_id/schemas/:id', function(req, res) {
    var schema = schemas.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'proxy_endpoint_schema': schema[0]
    });
  });

  schemasRouter.put('/:proxy_endpoint_id/schemas/:id', function(req, res) {
    var body = req.body;
    body.proxy_endpoint_schema.id = req.params.id;
    if (body.proxy_endpoint_schema.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.proxy_endpoint_schema.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  schemasRouter.delete('/:proxy_endpoint_id/schemas/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/proxy_endpoints', schemasRouter);
};
