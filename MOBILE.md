### Steps

#### Prerequisites
[Android Studio](https://developer.android.com/tools/studio/index.html) or Android SDK (``brew install android-sdk``) Please ensure to read the **Caveats** section.


    npm install -g cordova
    cd ~/src/cobudget-ui
    npm build # must build the ui first
    
    cordova create mobile co.cobudget.app Cobudget --link-to=build
    cd ./mobile
    cordova platform add browser
    cordova run browser
    
    cordova platform add android
    cordova build android
    cordova emulate android

To rebuild:

    cd .. ; rm -rf build/ ; NODE_ENV=development gulp build ; cd mobile

You must modify ``config/development.js`` to look like:

    module.exports = {
      apiPrefix: "http://10.0.2.2:3000/api/v1"
    }

You must launch the cobudget-api server using     

    bundle exec rails s -b 0.0.0.0
    