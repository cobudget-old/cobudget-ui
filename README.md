[![Build Status](https://travis-ci.org/open-app/cobudget-ui.svg?branch=master)](https://travis-ci.org/open-app/cobudget-ui)
[![Code Climate](https://codeclimate.com/github/open-app/cobudget-ui/badges/gpa.svg)](https://codeclimate.com/github/open-app/cobudget-ui)

##Cobudget user interface

[Trello Board](https://trello.com/b/LsbPRkRl/cobudget-dev) | [Style Guide](https://github.com/toddmotto/angularjs-styleguide)

Testing stack is chai, mocha, sinon and integration tests using protractor are in `features`

The initial angular prototype is in `prototype` we will be pulling out and reusing as much of that code into master as we go.

###Don't push to master - feature branches and pull requests please.

#### Configuration

We are using env-config and grunt-replace to manage configuration - checkout [this article](http://newtriks.com/2013/11/29/environment-specific-configuration-in-angularjs-using-grunt/) for an overview

To get up and running copy `config/environments/sample.json` to `config/environments/development.json` remove the comments, and add your custom settings.  At the moment you will also need to copy to `config/environments/staging.json`, and `config/environments/development.json`.

Likewise you will need to setup production.json and staging.json for deploying to work.

*To run locally:*

Install node and npm: https://github.com/joyent/node/wiki/Installation 

```
npm install
bower install (select angular version 1.2.21)
```

Install ruby 2 and bundler and run `bundle install`

*Start the server:*

```
grunt server
```

To debug server startup errors `grunt server --verbose`

*Testing*

```
webdriver-manager start
npm test (grunt test isn't playing friendly with protractor)
```

*Deploying*

```
bundle
cap production deploy
```
