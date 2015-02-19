module.exports = function(app) {
  var express = require('express');
  var hostsRouter = express.Router();
  var hosts = [
    {
        "api_id": 1,
        "id": 1,
        "name": "localhost"
    },
    {
        "api_id": 1,
        "id": 2,
        "name": "remotehost"
    },
    {
        "api_id": 1,
        "id": 3,
        "name": "test"
    }
  ];
  
  hostsRouter.get('/', function(req, res) {
    res.send({
      'hosts': hosts
    });
  });

  hostsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.host.id = id;
    res.status(201).send(body).end();
  });

  hostsRouter.get('/:id', function(req, res) {
    var host = hosts.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'host': host[0]
    });
  });
  
  hostsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.host.id = req.params.id;
    if (body.host.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.host.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  hostsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/hosts', hostsRouter);
};
