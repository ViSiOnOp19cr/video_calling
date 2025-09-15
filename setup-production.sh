#!/bin/bash

echo "🚀 Setting up Video Calling App in Production..."

# Copy ecosystem file
echo "📝 Setting up PM2 configuration..."
cp /var/www/videocall/ecosystem.config.js /var/www/videocall/

# Create PM2 log directory
mkdir -p /var/log/pm2

# Start the server with PM2
echo "🚀 Starting server with PM2..."
cd /var/www/videocall
pm2 start ecosystem.config.js

# Save PM2 configuration
pm2 save
pm2 startup

# Configure Nginx
echo "⚙️  Configuring Nginx..."
cp /var/www/videocall/nginx-config.conf /etc/nginx/sites-available/videocall
ln -sf /etc/nginx/sites-available/videocall /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
nginx -t

# Install Certbot for SSL
echo "🔒 Installing SSL certificate..."
apt install snapd -y
snap install core; snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot

echo "📋 Next steps to complete:"
echo "1. Run: certbot --nginx -d videocall.chandancr.xyz"
echo "2. Restart nginx: systemctl restart nginx"
echo "3. Check PM2 status: pm2 status"
echo "4. View logs: pm2 logs videocall-server"

echo "✅ Production setup complete!"
