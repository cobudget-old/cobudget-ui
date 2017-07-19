null

### @ngInject ###
global.cobudgetApp.factory 'UserModel', (BaseModel) ->
  class UserModel extends BaseModel
    @singular: 'user'
    @plural: 'users'

    @serializableAttributes: [
      'email',
      'name',
      'subscribedToPersonalActivity',
      'subscribedToDailyDigest',
      'subscribedToParticipantActivity',
      'confirmationToken',
      'isSuperAdmin'
    ]

    relationships: ->
      @hasMany 'memberships', with: 'memberId'
      @belongsTo 'subscriptionTracker'

    groupsToDisplay: () ->
      selectMemberships = _.filter @memberships(), (membership) ->
        membership.id

      groupIds = _.map selectMemberships, (membership) ->
        membership.groupId
      @recordStore.groups.find(groupIds)

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
      @groups()[0]

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
