`// @ngInject`
window.Cobudget.Resources.Allocation = (Restangular) ->
  # allocations = Restangular.all('allocations')
  update: (allocation_data)->
    allocation = Restangular.one('allocations', allocation_data.id).customPUT(allocation_data)
  createAllocation: (allocation_data)->
    # allocations.post('allocations', allocation_data)
