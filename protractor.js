require('coffee-script');

exports.config = {

  // The address of a running selenium server.
  seleniumAddress: 'http://localhost:4444/wd/hub',

  // Spec patterns are relative to the location of this config.
  specs: [
    'src/node_modules/**/e2e/**/*.coffee',
  ],

  framework: 'mocha',

  // ----- Options to be passed to mocha -----
  //
  // See the full list at http://visionmedia.github.io/mocha/
  mochaOpts: {
    reporter: 'dot',
    enableTimeouts: false,
  },

  capabilities: {
    'browserName': 'firefox',
    'chromeOptions': {'args': ['--disable-extensions']},
  },

  // A base URL for your application under test. Calls to protractor.get()
  // with relative paths will be prepended with this.
  baseUrl: 'http://localhost:9000',
};
