null

### @ngInject ###
global.cobudgetApp.factory 'BucketModel', (BaseModel) ->
  class BucketModel extends BaseModel
    @singular: 'bucket'
    @plural: 'buckets'
    @indices: ['groupId']
    @attributeNames = ['name', 'description', 'target', 'userId', 'groupId', 'createdAt']

    ageInDays: ->
      age = moment.duration(moment() - @createdAt)
      console.log('name: ', @name, ' age: ', age.asDays())
      parseInt(age.asDays())

    amountRemaining: ->
      @target - @totalContributions

    author: ->
      @recordStore.users.find(@userId)

    percentFunded: ->
      @totalContributions / @target * 100