module.exports = {
  apps: [{
    name: 'videocall-server',
    script: 'ts-node',
    args: 'src/index.ts',
    cwd: '/var/www/videocall/server',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production',
      PORT: 8000,
      DOMAIN: 'videocall.chandancr.xyz'
    },
    error_file: '/var/log/pm2/videocall-error.log',
    out_file: '/var/log/pm2/videocall-out.log',
    log_file: '/var/log/pm2/videocall-combined.log'
  }]
};
