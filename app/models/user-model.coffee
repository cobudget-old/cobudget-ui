null

### @ngInject ###
global.cobudgetApp.factory 'UserModel', (BaseModel) ->
  class UserModel extends BaseModel
    @singular: 'user'
    @plural: 'users'

    @serializableAttributes: [
      'email',
      'subscribedToPersonalActivity',
      'subscribedToDailyDigest',
      'subscribedToParticipantActivity',
      'confirmationToken',
      'isSuperAdmin'
    ]

    relationships: ->
      @hasMany 'memberships', with: 'memberId'
      @belongsTo 'subscriptionTracker'

    groups: () ->
      groupIds = _.map @memberships(), (membership) ->
        membership.groupId
      @recordStore.groups.find(groupIds)

    administeredGroups: () ->
      _.filter @groups(), (group) =>
        @isAdminOf(group)

    isAGroupAdmin: () ->
      @administeredGroups().length > 0

    primaryGroup: ->
      groupsByLastActivity = _.sortBy @groups(), (group) ->
        group.lastActivityAt
      groupsByLastActivity[groupsByLastActivity.length - 1]

    isMemberOf: (group) ->
      !!_.find @memberships(), (membership) ->
        membership.groupId == group.id

    isAdminOf: (group) ->
      !!_.find @memberships(), (membership) ->
        membership.groupId == group.id && membership.isAdmin

    isConfirmed: ->
      !!@confirmedAt

    hasEverJoinedAGroup: ->
      !!@joinedFirstGroupAt

    hasMemberships: ->
      @memberships().length > 0
