#!/bin/bash

echo "Removing old build..."
rm -rf dist

echo "Installing dependencies..."
npm install || exit 1

echo "Building..."
ng build --base-href / || exit 1

echo "Removing html folder from server..."
ssh root@3.111.53.6 "rm -rf /var/www/html/"

echo "Deploying keyshell-angular"
rsync -av dist/keyshell root@3.111.53.6:/var/www/html/

if [ $? -eq 0 ]; then
  echo "Deployment successful"
else
  echo "Deployment failed"
fi