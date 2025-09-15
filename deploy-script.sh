#!/bin/bash

# Video Calling App Deployment Script for Digital Ocean
echo "🚀 Starting deployment of Video Calling App..."

# Update system packages
echo "📦 Updating system packages..."
apt update && apt upgrade -y

# Install Node.js 20 (LTS)
echo "📦 Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
apt-get install -y nodejs

# Install nginx
echo "📦 Installing Nginx..."
apt install nginx -y

# Install PM2 globally
echo "📦 Installing PM2..."
npm install -g pm2

# Install git
echo "📦 Installing Git..."
apt install git -y

# Create application directory
echo "📁 Creating application directory..."
mkdir -p /var/www/videocall
cd /var/www/videocall

# Clone the repository
echo "📥 Cloning repository..."
git clone https://github.com/ViSiOnOp19cr/video_calling.git .

# Install server dependencies
echo "📦 Installing server dependencies..."
cd server
npm install
npm install -g ts-node typescript

# Build server
echo "🔨 Building server..."
npx tsc

# Install client dependencies and build
echo "📦 Installing client dependencies..."
cd ../client
npm install

# Build client for production
echo "🔨 Building client for production..."
npm run build

echo "✅ Basic installation complete!"
