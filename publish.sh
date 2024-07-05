#!/bin/bash

# Build the Flutter app for the web
flutter build web


# Copy the contents of the build/web directory to docs
cp -r build/web/* docs/

# Add, commit, and push changes
git add docs
git commit -m "Deploy updated Flutter Web App to GitHub Pages"
git push origin main
