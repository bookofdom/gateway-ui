module.exports = function(app) {
  var express = require('express');
  var apiRouter = express.Router();
  var apis = [
    {
      id: 1,
      name: 'MockAPI',
      description: 'A mock API for testing purposes.'
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
    res.send({
      'api': {
        id: req.params.id
      }
    });
  });

  apiRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/api/api', apiRouter);
};
