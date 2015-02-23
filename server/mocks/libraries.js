module.exports = function(app) {
  var express = require('express');
  var librariesRouter = express.Router();
  var libraries = [
    {
        "api_id": 1,
        "id": 1,
        "name": "Basic Library",
        "description": "Does something, anything.",
        "data": "magical js"
    },
    {
        "api_id": 1,
        "id": 2,
        "name": "Intermediate Library",
        "description": "Does something, anything.",
        "data": "magical js"
    },
    {
        "api_id": 1,
        "id": 3,
        "name": "Advanced Library",
        "description": "Does something, anything.",
        "data": "magical js"
    }
  ];

  librariesRouter.get('/', function(req, res) {
    res.send({
      'libraries': libraries
    });
  });

  librariesRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.library.id = id;
    res.status(201).send(body).end();
  });

  librariesRouter.get('/:id', function(req, res) {
    var library = libraries.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'library': library[0]
    });
  });

  librariesRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.library.id = req.params.id;
    if (body.library.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.libgrary.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  librariesRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/libraries', librariesRouter);
};
