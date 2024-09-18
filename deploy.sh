#!/bin/bash

# Check if the app directory exists, create it if it doesn't
if [ ! -d "/home/ubuntu/app" ]; then
  mkdir -p /home/ubuntu/app
else
  echo "Directory /home/ubuntu/app already exists."
fi

cd /home/ubuntu/app || exit

# Pull the latest changes from the repo (optional, depends on your workflow)
# git pull origin main

# Create a Python virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
  python3 -m venv venv
fi

# Activate the virtual environment
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt

# Run migrations if any (for example, if you're using Flask-Migrate)
# flask db upgrade

# Restart the Flask app service using systemd
sudo systemctl daemon-reload  # Reload systemd to detect changes in the service file (if any)
sudo systemctl start NetflixMovieCatalog.service  # Replace 'NetflixMovieCatalog.service' with your actual service name

# Optionally, check the status of the service to ensure it's running
sudo systemctl status NetflixMovieCatalog.service

echo "Deployment completed, and the service has been restarted!"
