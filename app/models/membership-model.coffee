null

### @ngInject ###
global.cobudgetApp.factory 'MembershipModel', (BaseModel) ->
  class MembershipModel extends BaseModel
    @singular: 'membership'
    @plural: 'memberships'
    @indices: ['groupId', 'memberId']
    @serializableAttributes: ['isAdmin', 'closedAdminHelpCardAt', 'closedMemberHelpCardAt', 'savedFundsAt']

    relationships: ->
      @belongsTo 'member', from: 'users'
      @belongsTo 'group'

    isPending: ->
      !@member().isConfirmed()

    cancel: ->
      @remote.postMember(@id, 'archive')
