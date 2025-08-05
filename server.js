#!/usr/bin/env node

const path = require('path');

// Load environment variables from .env file with explicit path
require('dotenv').config({ path: path.join(__dirname, '.env') });

console.log('Environment variables loaded:');
console.log('DATABASE_URL:', process.env.DATABASE_URL ? 'Set' : 'Not set');
console.log('JWT_SECRET:', process.env.JWT_SECRET ? 'Set' : 'Not set');
console.log('NODE_ENV:', process.env.NODE_ENV);
console.log('PORT:', process.env.PORT);
console.log('');
console.log('Starting backend server...');

try {
  const app = require('./dist/app.js').default || require('./dist/app.js');
  const PORT = process.env.PORT || 3001;
  
  app.listen(PORT, () => {
    console.log(`🚀 Restaurant POS API running on port ${PORT}`);
    console.log(`📝 Environment: ${process.env.NODE_ENV}`);
    console.log(`🔗 API Base URL: http://localhost:${PORT}/api/v1`);
  });
} catch (error) {
  console.error('Error starting backend:', error);
  process.exit(1);
}
