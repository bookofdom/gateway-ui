module.exports = function(app) {
  var express = require('express');
  var apiRouter = express.Router();
  var apis = [
    {
      id: 1,
      name: 'Mock API',
      description: 'Mock API for development purposes'
    },
    {
      id: 2,
      name: 'Demonstration API',
      description: 'Demonstration of the API resource'
    },
    {
      id: 3,
      name: 'Testing API',
      description: 'Another API for development purposes'
    }
  ];

  apiRouter.get('/', function(req, res) {
    res.send({
      'api': apis
    });
  });

  apiRouter.post('/', function(req, res) {
    res.status(201).end();
  });

  apiRouter.get('/:id', function(req, res) {
    res.send({
      'api': {
        id: req.params.id
      }
    });
  });

  apiRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.api.id = req.params.id;
    res.send(body);
  });

  apiRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/api/api', apiRouter);
};
