const express = require('express');
const app = express();
const port = 3000;

// Root route
app.get('/', (req, res) => {
  res.send('Welcome to the Node.js app!');
});

app.get('/api/greet', (req, res) => {
  res.json({ message: 'Hello from Dockerized Node.js app!' });
});

app.listen(port, () => {
  console.log(`App running at http://localhost:${port}`);
});
