const express = require('express');
const routes = require('./routes');
const bodyParser = require('body-parser');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Helloooo World!');
});

app.use('/', routes);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});