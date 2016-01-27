#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# for gardner's dev machine
export PATH=$PATH:~/Library/Android/sdk/build-tools/21.1.2

function req() {
  for cmd in "$@"; do
    if ! which $cmd >/dev/null; then
      echo "$cmd is required but not found in PATH";
      exit 1
    else
      echo $cmd found
    fi
  done
}

echo "Checking for required tools..."
req cordova android zipalign
echo "System meets build requirements."

echo ""
echo "Building web app."
cd $DIR/..
rm -rf build/
NODE_ENV=production AUTH_STORAGE=localStorage gulp build
cd mobile

echo "Building cordova wrapper app."
cordova build android --release

echo "Signing android APK."
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore cobudget.keystore \
  # -storepass $STORE_PASS \
  # -keypass $STORE_PASS \
  platforms/android/build/outputs/apk/android-release-unsigned.apk \
  cobudget

echo "Aligning APK file."
zipalign -v 4 \
  ~/src/cobudget-ui/mobile/platforms/android/build/outputs/apk/android-release-unsigned.apk \
  cobudget-release.apk

echo -n "Done: "
ls -lah cobudget-release.apk