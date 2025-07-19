# AutoMeet Backend Deployment Guide

## Issues Fixed

### 1. Security Issues
- ✅ Removed hardcoded MongoDB credentials
- ✅ Moved all sensitive data to configurable values
- ✅ Created separate production configuration

### 2. Configuration Issues
- ✅ Added proper MongoDB configuration in Config.toml
- ✅ Created environment-specific config files
- ✅ Added proper error handling for MongoDB connection

### 3. Deployment Issues
- ✅ Created Docker configuration
- ✅ Added health check endpoint
- ✅ Created deployment scripts

## Deployment Steps

### For Choreo Deployment (Current Setup)

#### 1. Access Your Live Deployment
Your project is deployed on WSO2 Choreo. To access it:

1. **Choreo Console**: https://console.choreo.dev/
2. **Organization**: `avishkavishmitha`
3. **Project**: `automeetbe`
4. **Component**: `BE`

#### 2. Get Your Live URLs
In the Choreo console, go to:
- **Deploy** → **Environment** (Development/Production)
- **Endpoints** section will show your live URLs

**Typical Choreo URL Format:**
```
Development: https://<component-id>-<build-id>.choreoapps.dev
Production: https://<component-id>-<build-id>.choreoapps.dev
```

#### 3. Test Your Deployment
Once you have the URL, test these endpoints:
```bash
# Health check
curl https://your-choreo-url.choreoapps.dev/health

# API test
curl https://your-choreo-url.choreoapps.dev/api/auth/status
```

### For Development
```bash
# 1. Install dependencies
bal build

# 2. Run with development config
bal run
```

### For Production (Docker)
```bash
# 1. Set environment variables
export MONGODB_CONNECTION_STRING="your-production-mongodb-url"
export MONGODB_DATABASE_NAME="automeet"
export GOOGLE_CLIENT_ID="your-google-client-id"
export GOOGLE_CLIENT_SECRET="your-google-client-secret"
export JWT_SECRET_PROD="your-jwt-secret"
export JWT_SIGNING_KEY_PROD="your-jwt-signing-key"
export HUGGING_FACE_API_KEY="your-hf-api-key"
export PRODUCTION_URL="https://your-production-domain.com"
export FRONTEND_PRODUCTION_URL="https://your-frontend-domain.com"

# 2. Build and run with Docker
docker-compose up --build
```

### For Production (Direct)
```bash
# 1. Update Config.prod.toml with production values
# 2. Run deployment script
./deploy.sh  # Linux/Mac
# or
deploy.bat   # Windows
```

## How to Get Your Live Base URLs

### Method 1: Choreo Console (Recommended)
1. Go to https://console.choreo.dev/
2. Login with your account
3. Navigate: `avishkavishmitha` → `automeetbe` → `BE`
4. Click on **"Deploy"** tab
5. Select your environment (Development/Production)
6. Look for **"Endpoints"** section - your live URL will be displayed there

### Method 2: Check Deployment Logs
In the Choreo console:
1. Go to **"Observability"** → **"Logs"**
2. Look for deployment logs that contain the assigned URL

### Method 3: Test Common Endpoints
If you know the pattern, try accessing:
```
https://automeetbe-{random-id}.choreoapps.dev/health
https://automeetbe-{random-id}.choreoapps.dev/api/auth/status
```

## Your Current Deployment Status

### Production Environment Variables
- `MONGODB_CONNECTION_STRING` - Your MongoDB Atlas connection string
- `MONGODB_DATABASE_NAME` - Database name (e.g., "automeet")
- `GOOGLE_CLIENT_ID` - Google OAuth client ID
- `GOOGLE_CLIENT_SECRET` - Google OAuth client secret
- `JWT_SECRET_PROD` - JWT secret for production
- `JWT_SIGNING_KEY_PROD` - JWT signing key for production
- `HUGGING_FACE_API_KEY` - Hugging Face API key
- `PRODUCTION_URL` - Your backend production URL
- `FRONTEND_PRODUCTION_URL` - Your frontend production URL

## Health Check
- Endpoint: `GET /health`
- Response: JSON with service status

## Common Deployment Errors Fixed

1. **Hardcoded credentials** - Now using configurable values
2. **Missing MongoDB configuration** - Added to Config.toml
3. **No error handling** - Added proper error logging
4. **No health checks** - Added health endpoint
5. **No environment separation** - Created prod/dev configs

## Security Best Practices Applied

1. ✅ No hardcoded secrets in code
2. ✅ Environment-specific configurations
3. ✅ Proper error handling without exposing sensitive data
4. ✅ Health check endpoint for monitoring
5. ✅ Docker containerization for consistent deployment

## Your Current Deployment Status

From your screenshot, I can see:
- **Development**: ✅ Active (deployed 11 minutes ago)
- **Production**: ❌ Error (needs to be fixed)

## Troubleshooting Access Issues

### Common Error: "Invalid Credentials" (900901)
If you get this error when accessing `/health`:
```json
{
  "error_message": "Invalid Credentials",
  "code": "900901", 
  "error_description": "Make sure you have provided the correct security credentials"
}
```

**This means your Choreo endpoint requires authentication. Here's how to fix it:**

#### Solution 1: Configure Endpoint Security in Choreo
1. Go to Choreo Console → Your Component → **"Endpoints"**
2. Click on your endpoint configuration
3. Look for **"Security"** or **"Authentication"** settings
4. **Disable authentication** for health check endpoint OR
5. **Add API Key authentication** if required

#### Solution 2: Use API Key (if required)
If your endpoint requires an API key:
```bash
# Add API key header
curl -H "Authorization: Bearer YOUR_API_KEY" https://your-app.choreoapps.dev/health

# Or use API key header
curl -H "apikey: YOUR_API_KEY" https://your-app.choreoapps.dev/health
```

#### Solution 3: Check Endpoint Configuration
In Choreo console:
1. Go to **"Manage"** → **"Endpoints"**
2. Check if the endpoint is **"Secured"** or **"Unsecured"**
3. For health checks, it should typically be **"Unsecured"**

### If You Can't Find Your URL:
1. **Check Choreo Dashboard**: The endpoints should be visible in the Deploy section
2. **Check Build Logs**: Look for any URL mentions in the build/deploy logs
3. **Verify Deployment Status**: Ensure the deployment completed successfully

### If URL Returns Errors:
1. **Check Health Endpoint**: `GET /health` should return service status
2. **Check MongoDB Connection**: Ensure your Config.toml has correct MongoDB URL
3. **Check Environment Variables**: Verify all required configs are set

### Common Choreo URL Patterns:
```bash
# Health check
https://your-app.choreoapps.dev/health

# API endpoints
https://your-app.choreoapps.dev/api/auth/status
https://your-app.choreoapps.dev/api/users/profile
https://your-app.choreoapps.dev/api/meetings
```

## Quick Access Steps - UPDATED

1. **Login to Choreo**: https://console.choreo.dev/
2. **Navigate**: `avishkavishmitha` → `automeetbe` → `BE`
3. **Configure Endpoints**:
   - Go to **"Manage"** → **"Endpoints"**
   - Find your service endpoint
   - Check **"Authentication"** settings
   - **Disable authentication** for `/health` endpoint
4. **Get URL**: Deploy tab → Endpoints section
5. **Test**: Add `/health` to your URL to verify it's working

### Alternative: Create Unsecured Health Endpoint

If you need to keep your main endpoints secured but want an unsecured health check:

1. **In Choreo Console**: Go to Manage → Endpoints
2. **Create/Edit Endpoint**: Make sure health endpoint is marked as "Unsecured"
3. **Save Configuration**
4. **Redeploy if necessary**

Your development environment should be accessible now since it shows "Active" status!
