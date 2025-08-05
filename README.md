# CafeBuddyPOS Backend

A robust REST API backend for the CafeBuddy Point of Sale system built with Express.js, TypeScript, and Drizzle ORM.

## Features

- 🔐 JWT Authentication & Authorization
- 📝 Menu Management (Categories, Items)
- 🏪 Table Management
- 📋 Order Processing
- 👥 User Management (Staff/Admin)
- 🛡️ Input Validation & Security Middleware
- 📊 Database with PostgreSQL + Drizzle ORM
- 🚀 Ready for Vercel Deployment

## Tech Stack

- **Framework**: Express.js with TypeScript
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: JWT
- **Validation**: Zod
- **Security**: Helmet, CORS, Rate Limiting
- **Build**: esbuild for fast compilation

## Project Structure

```
src/
├── app.ts              # Main application setup
├── config/
│   ├── database.ts     # Database connection
│   └── environment.ts  # Environment variables
├── controllers/        # Route handlers
├── middleware/         # Custom middleware
├── models/            # Database models/schema
├── routes/            # API route definitions
└── services/          # Business logic
```

## Environment Setup

1. Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```

2. Update environment variables:
```env
DATABASE_URL="your-postgresql-database-url"
JWT_SECRET="your-super-secret-jwt-key"
NODE_ENV="development"
PORT="3000"
CORS_ORIGIN="http://localhost:5173"
```

## Development

```bash
# Install dependencies
npm install

# Run in development mode
npm run dev

# Build for production
npm run build

# Start production server
npm start

# Database operations
npm run db:generate  # Generate migrations
npm run db:migrate   # Run migrations
npm run db:push      # Push schema to database
```

## API Endpoints

### Authentication
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/register` - User registration
- `GET /api/v1/auth/profile` - Get user profile

### Menu Management
- `GET /api/v1/menu/categories` - Get all categories
- `POST /api/v1/menu/categories` - Create category
- `GET /api/v1/menu/items` - Get all menu items
- `POST /api/v1/menu/items` - Create menu item

### Table Management
- `GET /api/v1/tables` - Get all tables
- `POST /api/v1/tables` - Create table
- `PATCH /api/v1/tables/:id/status` - Update table status

### Orders
- `GET /api/v1/orders` - Get all orders
- `POST /api/v1/orders` - Create new order
- `PATCH /api/v1/orders/:id/status` - Update order status

### Health Check
- `GET /api/v1/health` - API health status

## Database Schema

The database includes the following tables:
- `users` - Staff/admin users
- `categories` - Menu categories
- `menu_items` - Restaurant menu items
- `tables` - Restaurant tables
- `orders` - Customer orders
- `order_items` - Items within orders

## Deployment

### Vercel Deployment

1. Build the project:
```bash
npm run build
```

2. Configure environment variables in Vercel dashboard:
   - `DATABASE_URL`
   - `JWT_SECRET`
   - `NODE_ENV=production`
   - `CORS_ORIGIN=https://your-frontend-domain.vercel.app`

3. Deploy using Vercel CLI or GitHub integration

The `vercel.json` configuration is already set up for deployment.

## Security Features

- Rate limiting (100 requests per 15 minutes)
- CORS configuration
- Helmet security headers
- Input validation with Zod
- JWT authentication
- Password hashing with bcrypt

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request
