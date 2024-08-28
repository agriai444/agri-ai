#!/bin/bash

# Save the current directory to return to later
original_dir=$(pwd)

# Change to the admin directory and run the admin script
cd code/admin-web || { echo "Failed to change directory to code/admin"; exit 1; }
bash d.sh

# Return to the original directory
cd "$original_dir" || { echo "Failed to return to the original directory"; exit 1; }

# Change to the agriapp directory and build the agriapp
cd code/agriapp || { echo "Failed to change directory to code/agriapp"; exit 1; }
bash build.sh

# Return to the original directory
cd "$original_dir" || { echo "Failed to return to the original directory"; exit 1; }

# Copy the APK file to the output directory
cp code/agriapp/build/app/outputs/flutter-apk/app-release.apk output/app/android/agri-expert.apk

# Uncomment if initializing a new Git repository
# git init

# Add all changes to Git
git add .

# Commit changes with a message
git commit -m "i commit"

# Uncomment and set the remote repository URL if not already set
# git remote add origin https://github.com/agriai444/agri-ai.git

# Uncomment if renaming the default branch to 'main'
# git branch -M main

# Push changes to the remote repository
git push -u origin main
