// Vercel serverless function entry point
require('dotenv').config();

const app = require('./dist/app.js').default || require('./dist/app.js');

module.exports = app;
