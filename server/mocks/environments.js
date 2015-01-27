module.exports = function(app) {
  var express = require('express');
  var environmentsRouter = express.Router();
  var environments = [
    {
      id: 1,
      name: 'Development',
      description: 'Environment for development purposes'
    },
    {
      id: 2,
      name: 'Staging',
      description: 'Environment for staging purposes'
    },
    {
      id: 3,
      name: 'Production',
      description: 'Environment for production purposes'
    }
  ];

  environmentsRouter.get('/', function(req, res) {
    res.send({
      'environments': environments
    });
  });
  
  environmentsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.environment.id = id;
    res.status(201).send(body).end();
  });
  
  environmentsRouter.get('/:id', function(req, res) {
    res.send({
      'environment': {
        id: req.params.id
      }
    });
  });

  environmentsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.environment.id = req.params.id;
    if (body.environment.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}})
    } else {
      res.send(body);
    }
  });

  environmentsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/environments', environmentsRouter);
};
