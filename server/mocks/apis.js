module.exports = function(app) {
  var express = require('express');
  var apisRouter = express.Router();
  var apis = [
    {
      id: 1,
      name: 'Mock API',
      base_url: 'http://poor-choices-1234.lvh.me:5000',
      description: 'Mock API for development purposes',
      cors_allow_origin: "",
      cors_allow_headers: "content-type, accept",
      cors_allow_credentials: true,
      cors_request_headers: "",
      cors_max_age: 600
    },
    {
      id: 2,
      name: 'Demonstration API',
      base_url: 'http://regretful-decisions-1234.lvh.me:5000',
      description: 'Demonstration of the API resource',
      cors_allow_origin: "",
      cors_allow_headers: "content-type, accept",
      cors_allow_credentials: true,
      cors_request_headers: "",
      cors_max_age: 600
    },
    {
      id: 3,
      name: 'Testing API',
      base_url: 'http://fateful-encounters-1234.lvh.me:5000',
      description: 'Another API for development purposes',
      cors_allow_origin: "",
      cors_allow_headers: "content-type, accept",
      cors_allow_credentials: true,
      cors_request_headers: "",
      cors_max_age: 600
    }
  ];

  apisRouter.get('/', function(req, res) {
    res.send({
      'apis': apis
    });
  });

  apisRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.api.id = id;
    res.status(201).send(body).end();
  });

  apisRouter.post('/import', function(req, res) {
    var body = {
      'error': 'Inserting API: Developer version allows 1 api(s).'
    }
    res.status(500).send(body).end();
  });

  apisRouter.get('/:id', function(req, res) {
    var api = apis.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'api': api[0]
    });
  });

  apisRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.api.id = req.params.id;
    if (body.api.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.api.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  apisRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis', apisRouter);
};
