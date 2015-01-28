module.exports = function(app) {
  var express = require('express');
  var endpointGroupsRouter = express.Router();
  var groups = [
    {
      id: 1,
      name: 'Group A',
      description: 'This group is named "A"'
    },
    {
      id: 2,
      name: 'Group B',
      description: 'This group is named "B"'
    },
    {
      id: 3,
      name: 'Group C',
      description: 'This group is named "C"'
    }
  ];
  
  endpointGroupsRouter.get('/', function(req, res) {
    res.send({
      'endpoint_groups': groups
    });
  });

  endpointGroupsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.endpoint_group.id = id;
    res.status(201).send(body).end();
  });

  endpointGroupsRouter.get('/:id', function(req, res) {
    res.send({
      'endpoint_group': {
        id: req.params.id
      }
    });
  });

  endpointGroupsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.endpoint_group.id = req.params.id;
    if (body.endpoint_group.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}})
    } else {
      res.send(body);
    }
  });

  endpointGroupsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/endpoint_groups', endpointGroupsRouter);
};
