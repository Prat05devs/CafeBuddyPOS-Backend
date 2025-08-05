#!/bin/bash

# 🧪 CafeBuddy POS - Production Testing Script
# This script tests both frontend and backend deployments on Vercel

echo "🧪 Testing CafeBuddy POS Deployments on Vercel"
echo "=============================================="

# Configuration - UPDATE THESE WITH YOUR ACTUAL DOMAINS
BACKEND_URL="https://your-backend-domain.vercel.app"
FRONTEND_URL="https://your-frontend-domain.vercel.app"

echo ""
echo "🔧 Configuration:"
echo "Backend URL: $BACKEND_URL"
echo "Frontend URL: $FRONTEND_URL"
echo ""

# Test 1: Backend Health Check
echo "🏥 Test 1: Backend Health Check"
echo "--------------------------------"
HEALTH_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$BACKEND_URL/api/v1/health")
if [ "$HEALTH_RESPONSE" = "200" ]; then
    echo "✅ Backend health check: PASS (200 OK)"
    echo "   Response: $(curl -s "$BACKEND_URL/api/v1/health" | head -c 100)..."
else
    echo "❌ Backend health check: FAIL ($HEALTH_RESPONSE)"
    echo "   Check your backend deployment and environment variables"
fi

echo ""

# Test 2: Database Connection (Categories)
echo "🗄️  Test 2: Database Connection (Categories)"
echo "--------------------------------------------"
CATEGORIES_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$BACKEND_URL/api/v1/menu/categories")
if [ "$CATEGORIES_RESPONSE" = "200" ]; then
    echo "✅ Database connection: PASS (200 OK)"
    CATEGORY_COUNT=$(curl -s "$BACKEND_URL/api/v1/menu/categories" | grep -o '"id":' | wc -l)
    echo "   Found $CATEGORY_COUNT categories in database"
else
    echo "❌ Database connection: FAIL ($CATEGORIES_RESPONSE)"
    echo "   Check your DATABASE_URL environment variable"
fi

echo ""

# Test 3: Menu Items API
echo "🍽️  Test 3: Menu Items API"
echo "---------------------------"
MENU_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$BACKEND_URL/api/v1/menu/items")
if [ "$MENU_RESPONSE" = "200" ]; then
    echo "✅ Menu items API: PASS (200 OK)"
    ITEM_COUNT=$(curl -s "$BACKEND_URL/api/v1/menu/items" | grep -o '"id":' | wc -l)
    echo "   Found $ITEM_COUNT menu items in database"
else
    echo "❌ Menu items API: FAIL ($MENU_RESPONSE)"
fi

echo ""

# Test 4: Frontend Accessibility
echo "🌐 Test 4: Frontend Accessibility"
echo "----------------------------------"
FRONTEND_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$FRONTEND_URL")
if [ "$FRONTEND_RESPONSE" = "200" ]; then
    echo "✅ Frontend accessibility: PASS (200 OK)"
    echo "   Frontend is accessible and serving content"
else
    echo "❌ Frontend accessibility: FAIL ($FRONTEND_RESPONSE)"
    echo "   Check your frontend deployment"
fi

echo ""

# Test 5: CORS Configuration
echo "🔒 Test 5: CORS Configuration"
echo "------------------------------"
CORS_TEST=$(curl -s -H "Origin: $FRONTEND_URL" -H "Access-Control-Request-Method: GET" -H "Access-Control-Request-Headers: Content-Type" -X OPTIONS "$BACKEND_URL/api/v1/health" -w "%{http_code}")
if [[ "$CORS_TEST" =~ "200" ]]; then
    echo "✅ CORS configuration: PASS"
    echo "   Frontend can communicate with backend"
else
    echo "❌ CORS configuration: FAIL"
    echo "   Update CORS_ORIGIN in backend to: $FRONTEND_URL"
fi

echo ""
echo "🏁 Testing Complete!"
echo "===================="
echo ""

# Summary and next steps
echo "📋 Next Steps:"
echo "1. If any tests failed, check the troubleshooting guide"
echo "2. Update environment variables if needed"
echo "3. Redeploy if configuration changes were made"
echo "4. Test the frontend manually by visiting: $FRONTEND_URL"
echo ""

echo "🔍 Manual Testing Checklist:"
echo "□ Visit $FRONTEND_URL in browser"
echo "□ Check browser console for errors (F12)"
echo "□ Verify menu items load correctly"
echo "□ Test creating an order"
echo "□ Check that all API calls succeed"
echo ""

echo "🆘 If issues persist:"
echo "• Check Vercel function logs for detailed errors"
echo "• Verify all environment variables are set correctly"
echo "• Ensure database is accessible from Vercel"
