
`// @ngInject`
module.exports = (Restangular) ->

  get: (budget_id)->
    Restangular.one('budgets', budget_id).get()

  allBudgets: ()->
    Restangular.all('budgets').getList()

  myBudgets: ->
    #TODO restrict to only getting budgets visible by this user
    @allBudgets().$object

  getBudgetBuckets: (budget_id, state, limit)->
    state ||= "open"
    limit ||= ""
    Restangular.one('budgets', budget_id).customGET('buckets', {state: state, limit: limit})

#  createBudget: (budget_data)->
#    budgets.post('budgets', budget_data)
#
#  getUserAllocated: (user_allocations)->
#    sum = 0
#    angular.forEach user_allocations, (allocation)->
#      unless allocation.user_id == undefined
#        sum += allocation.amount
#    return sum
#  
#  #amount in balance (entries summed for budget) + amount allocated in current collection of buckets
#  getUserAllocatable: (account_balance, allocated_amount)->
#    parseFloat(account_balance) + allocated_amount

#
#  getUserAllocatedExceptBucket: (user_allocations, except_bucket_id)->
#    sum = 0
#    for allocation in user_allocations
#      unless allocation.bucket_id == except_bucket_id
#        sum += allocation
