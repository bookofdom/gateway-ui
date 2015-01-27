module.exports = function(app) {
  var express = require('express');
  var apisRouter = express.Router();
  var apis = [
    {
      id: 1,
      name: 'Mock API',
      description: 'Mock API for development purposes',
      cors_allow: '*'
    },
    {
      id: 2,
      name: 'Demonstration API',
      description: 'Demonstration of the API resource',
      cors_allow: '*'
    },
    {
      id: 3,
      name: 'Testing API',
      description: 'Another API for development purposes',
      cors_allow: '*'
    }
  ];

  apisRouter.get('/', function(req, res) {
    res.send({
      'api': apis
    });
  });

  apisRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.api.id = id;
    res.status(201).send(body).end();
  });
  
  apisRouter.get('/:id', function(req, res) {
    res.send({
      'api': {
        id: req.params.id
      }
    });
  });

  apisRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.api.id = req.params.id;
    if (body.api.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}})
    } else {
      res.send(body);
    }
  });

  apisRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis', apisRouter);
};
