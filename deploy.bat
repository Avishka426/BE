@echo off
REM Deployment script for AutoMeetBE on Windows

echo Starting deployment process...

REM Set environment variables for production
set ENVIRONMENT=production

REM Build the application
echo Building Ballerina application...
bal build

if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    exit /b 1
)

REM Run with production config
echo Starting application with production configuration...
bal run --config-file Config.prod.toml

echo Deployment completed successfully!
