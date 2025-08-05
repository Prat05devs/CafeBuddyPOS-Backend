# 🚀 Vercel Deployment Guide

## Quick Deploy to Vercel

### Option 1: Deploy via Vercel Dashboard
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project" 
3. Import from GitHub: `https://github.com/Prat05devs/CafeBuddyPOS-Backend`
4. Configure environment variables (see below)
5. Deploy!

### Option 2: Deploy via CLI
```bash
# Install Vercel CLI (if not already installed)
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
vercel --prod
```

## ⚙️ Required Environment Variables

Set these in your Vercel project settings:

```env
DATABASE_URL=postgresql://postgres.clweuoqkstorxonixcng:Pt@140502@aws-0-ap-south-1.pooler.supabase.com:6543/postgres
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
NODE_ENV=production
CORS_ORIGIN=https://your-frontend-domain.vercel.app
```

## 🔧 Post-Deployment Steps

1. **Test the deployment**:
   ```bash
   curl https://your-backend-domain.vercel.app/api/v1/health
   ```

2. **Update frontend API URL**:
   - In your frontend project
   - Update API base URL to: `https://your-backend-domain.vercel.app`

3. **Update CORS_ORIGIN**:
   - After deploying frontend, update CORS_ORIGIN to your frontend domain
   - Redeploy backend

## 🔗 API Endpoints

Once deployed, your API will be available at:
- Health Check: `GET /api/v1/health`
- Categories: `GET /api/v1/menu/categories`  
- Menu Items: `GET /api/v1/menu/items`
- Tables: `GET /api/v1/tables` (requires auth)
- Login: `POST /api/v1/auth/login`
- Orders: `POST /api/v1/orders` (requires auth)

## 🛡️ Security Notes

- JWT_SECRET should be a strong, random string in production
- Database credentials are already configured for Supabase
- CORS is configured to accept requests only from your frontend domain

## 📝 Frontend Integration

Update your frontend's API configuration to point to the deployed backend:

```typescript
// In your frontend project
const API_BASE_URL = 'https://your-backend-domain.vercel.app/api/v1';
```
