#!/bin/bash

echo "🚨 Cleaning React Native iOS build environment..."

# 1. Kill Metro Bundler if running
pkill -f "node .*react-native"

# 2. Remove build artifacts
rm -rf ios/build
rm -rf ios/Pods
rm -f ios/Podfile.lock
rm -rf node_modules
rm -f package-lock.json
rm -f yarn.lock

# 3. Clean Xcode DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData

# 4. Reinstall Node modules
echo "📦 Installing npm packages..."
npm install || yarn install

# 5. Reinstall CocoaPods
echo "📦 Installing iOS pods..."
cd ios
pod install
cd ..

# 6. Rebuild iOS app
echo "🚀 Running app on iOS simulator..."
npx react-native run-ios

echo "✅ Done!"

