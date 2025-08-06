import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import path from 'path';
import { config } from './config/environment';
import routes from './routes';
import { errorHandler, notFound } from './middleware/error.middleware';

const app = express();

// Basic error handling for uncaught exceptions
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
});

process.on('unhandledRejection', (err) => {
  console.error('Unhandled Rejection:', err);
});

// Security middleware
app.use(helmet({
  contentSecurityPolicy: false, // Disable CSP for simplicity in development
}));

app.use(cors({
  origin: config.cors.origin,
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: {
    success: false,
    message: 'Too many requests from this IP, please try again later.',
  },
});

app.use(limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Request logging middleware
app.use((req, res, next) => {
  if (config.isDevelopment) {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  }
  next();
});

// Handle favicon.ico
app.get('/favicon.ico', (req, res) => res.status(204).end());

// Root route for basic health check
app.get('/', (req, res) => {
  try {
    res.json({
      success: true,
      message: 'Restaurant POS API is running',
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error('Error in root route:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error'
    });
  }
});

// API routes
app.use('/api/v1', routes);

// 404 handler for API routes
app.use('/api/*', notFound);

// Generic 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Route not found'
  });
});

// Error handling middleware
app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
  console.error('Global error handler:', err);
  if (res.headersSent) {
    return next(err);
  }
  res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

const PORT = config.port;

// Only start server if running directly (not in serverless environment)
if (require.main === module && process.env.NODE_ENV !== 'production') {
  app.listen(PORT, () => {
    console.log(`🚀 Restaurant POS API running on port ${PORT}`);
    console.log(`📝 Environment: ${process.env.NODE_ENV}`);
    console.log(`🔗 API Base URL: http://localhost:${PORT}/api/v1`);
  });
}

// Export the app for Vercel
export default app;