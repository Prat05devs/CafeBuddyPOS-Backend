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

⚠️ **Important**: Make sure to set these environment variables in your Vercel project settings BEFORE deploying, as missing environment variables will cause the deployment to crash.

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

## 🔧 Troubleshooting Deployment Issues

### 500: INTERNAL_SERVER_ERROR / FUNCTION_INVOCATION_FAILED

This error usually indicates missing environment variables or build issues. Follow these steps:

1. **Check Environment Variables**:
   - Go to your Vercel project → Settings → Environment Variables
   - Ensure all required variables are set (see above)
   - Redeploy after adding environment variables

2. **Check Build Output**:
   - Ensure `npm run build` completes successfully locally
   - Check that `dist/app.js` is generated

3. **Check Vercel Function Logs**:
   - Go to your Vercel project → Functions tab
   - Click on the failing function to see detailed error logs

4. **Common Issues**:
   - Missing `DATABASE_URL` → Add your Supabase connection string
   - Missing `JWT_SECRET` → Add a secure random string
   - Wrong `NODE_ENV` → Should be "production"
   - Database connection timeout → Check Supabase database status

### Database Connection Issues

If you see database-related errors:
- Verify your Supabase database is running
- Check that the `DATABASE_URL` is correct
- Ensure your Supabase project allows connections from Vercel

### Re-deploy Steps

After fixing environment variables:
1. Go to Vercel project → Deployments
2. Click "..." on latest deployment → Redeploy
3. Or push a new commit to trigger automatic deployment
