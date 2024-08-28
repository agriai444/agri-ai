#!/bin/bash
bash code/admin/d.sh
bash code/agriapp/build.sh
cp code/agriapp/build/app/outputs/flutter-apk/app-release.apk  output/app/android/agri-expert.apk
# git init
git add .
git commit -m "i commit"
# git remote add origin https://github.com/agriai444/agri-ai.git
# git branch -M main
git push -u origin main 