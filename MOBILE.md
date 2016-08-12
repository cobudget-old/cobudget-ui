### Steps

#### Prerequisites
[Android Studio](https://developer.android.com/tools/studio/index.html) or Android SDK (``brew install android-sdk``) Please ensure to read the **Caveats** section.

    

    npm install cordova cordova-icon -g
    cd ~/src/cobudget-ui
    npm build # must build the ui first
    
    cordova create mobile co.cobudget.app Cobudget --link-to=build
    cd ./mobile
    cordova plugin add cordova-plugin-google-analytics
    cordova platform add browser
    cordova run browser
    
    cordova platform add android
    cordova build android
    cordova emulate android

To rebuild:

    cd .. ; rm -rf build/ ; NODE_ENV=development gulp build ; cd mobile
    cd .. ; rm -rf build/ ; NODE_ENV=development AUTH_STORAGE=localStorage API_ENDPOINT="http://10.0.2.2:3000/api/v1" gulp build ; cd mobile

You must modify ``config/development.js`` to look like:

    module.exports = {
      apiPrefix: "http://10.0.2.2:3000/api/v1"
    }

You must launch the cobudget-api server using     

    bundle exec rails s -b 0.0.0.0

### Deploy

#### Android

There is a bug in cordova android plugin version number generation. For more information please see:
https://stackoverflow.com/questions/32951375/why-does-cordova-phonegap-append-8-to-my-android-version-code
https://issues.apache.org/jira/browse/CB-8976?jql=text%20~%20%22versionCode%22

To work around this issue the please inspect ``mobile/platforms/android/build.gradle`` and update line ~165:

    versionCode cdvVersionCode ?: Integer.parseInt("" + privateHelpers.extractIntFromManifest("versionCode")) + "0"

to be

    versionCode cdvVersionCode ?: Integer.parseInt("" + privateHelpers.extractIntFromManifest("versionCode"))


##### Building Android

    cd .. ; rm -rf build/ ; NODE_ENV=production AUTH_STORAGE=localStorage gulp build ; cd mobile

    keytool -genkey -v -keystore cobudget.keystore -alias cobudget -keyalg RSA -keysize 2048 -validity 10000

    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
      -keystore ~/MEGA/projects/cobudget/cobudget.keystore \
      platforms/android/build/outputs/apk/android-release-unsigned.apk cobudget

    ~/Library/Android/sdk/build-tools/21.1.2/zipalign -v 4 \
      ~/src/cobudget-ui/mobile/platforms/android/build/outputs/apk/android-release-unsigned.apk \
      cobudget-release.apk

#### iOS
    cd .. ; rm -rf build/ ; NODE_ENV=production AUTH_STORAGE=localStorage gulp build ; cd mobile
    cordova build ios --release --device

