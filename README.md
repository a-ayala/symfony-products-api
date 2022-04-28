# App

## Getting Started

```
# Build the containers configured in docker-compose.ymal
make build

# Start the containers
make up

# Install composer dependencies
make vendor

# (optionally) Configure a .env.local file
cp .env .env.local

# Visit localhost:8080 in your browser!
```

## Docker Configuration
Simple docker stack for local development.

**Configured with:**
- Nginx
- PHP
- XDebug

Run `make` for a list of commands.

## Todo
- Conditionally install / run xdebug though a docker-compose override