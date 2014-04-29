angular.module("directives.buckets_collection", [])
.directive "bucketsCollection", ['$q', '$rootScope', '$state', '$timeout', 'Budget', 'User', 'Allocation', 'Bucket', 'ColorGenerator', 'Time', '$compile', ($q, $rootScope, $state, $timeout, Budget, User, Allocation, Bucket, ColorGenerator, Time, $compile) ->
  restrict: "EA"
  templateUrl: "/views/directives/buckets.collection.html"
  controller: 'BucketController'
  scope:
    budget_id: "@budgetId"
    account_balance: "@accountBalance"

  link: (scope, element, attrs) ->
    console.log "BUCKETS COlLECTION", scope, $state.params
    console.log 'bwa', scope.budget_id, 'root', $rootScope

    chartParams =
      width: 750
      height: 600
      margin:
        top: 20
        gap: 5
      dragbarw: 20

    svg = d3.select(element[0]).append('svg')
      .attr('width', chartParams.width)
      .attr('height', chartParams.height)

    blobG = svg.append('g').attr('class', 'blobG')
      .attr('transform', 'translate(' + chartParams.width/2 + ','+ chartParams.margin.top + ')')


    #utils
    spawn = (d)->
      group = d3.select(this.parentElement.parentElement)
      blob = group.select('.bloblet')
      direction = d3.select(this).attr('class').split(' ')[1]

      gTrans = group.attr('transform')
      transform = blob.attr('transform')
      transX = 0
      transY = 0
      if transform
        transform = transform[10..].split(',')
        transX += parseInt transform[0]
        transY += parseInt transform[1]
      transX += if direction is 'right' then (d.width + 5) else -5

      g = d3.select('.blobG')
      spawn = g.append('g')
        .attr('id', 'spawn')
        .attr('class', 'blobletG')
        .attr('transform', gTrans)

      spawn.append('rect')
        .attr('transform', 'translate(' +transX+ ',' +transY+ ')')
        .attr('class', 'bloblet')
        .attr('x', 0)
        .attr('y', 0)
        .attr('rx', 10).attr('ry', 10)
        .attr('width', 1)
        .attr('height', d.height)


    dragresize = (d)->
      direction = d3.select(this).attr('class').split(' ')[1]
      blob = d3.select(this.parentElement.parentElement).select('.bloblet')
      blobX = parseInt blob.attr('x')
      width = d.width
      x = parseInt d3.select(this).attr('x')
      nX = Math.max(0, Math.min(x + d3.event.dx,blobX + width))
      handle = d3.select(this)
          .attr("x", nX )

      spawnBlob = d3.select('#spawn').select('.bloblet')
      transform = spawnBlob.attr('transform')[10..].split(',')
      spawnBlobX = parseInt transform[0]
      spawnBlobY = parseInt transform[1]

      nWidth = 0
      nSpawnBlobX = spawnBlobX

      if direction is 'right'
        nSpawnBlobX += parseInt(nX - x)
        nWidth = Math.max(0,Math.min(nX - blobX,width))
      else
        nWidth = Math.max(0,Math.min(width - nX,width))
        blob.attr('x', nX)

      blob.attr('width', nWidth)

      nAmount = parseInt((nWidth/width) * d.amount)
      d.remainder = d.amount - nAmount

      spawnBlob
        .attr('transform', 'translate(' +nSpawnBlobX+ ',' +spawnBlobY+ ')')
        .attr('width', d.scale(d.remainder))

    spawnSet = (d) ->
      spawnG = d3.select('#spawn')
      spawn = spawnG.select('rect')
      rectTrans = if spawn.attr('transform') then spawn.attr('transform') else 'translate(0,0)'

      spawnData =
        amount: d.remainder
        width: parseInt spawn.attr('width')
        height: parseInt spawn.attr('height')
        x: parseInt spawn.attr('x')
        y: parseInt spawn.attr('y')
        gTrans: spawnG.attr('transform')
        rectTrans: rectTrans
        scale: d.scale

      d.amount = d.amount - d.remainder
      d.remainder = 0
      d3.select(this.parentElement.parentElement).datum(d)
      blobSet(d3.select('.blobG'), spawnData)
      spawnG.remove()

    blobSet = (group, d)->
      group.datum(d)

      bloblet = group.append('g')
        .attr('class', 'blobletG')
        .attr('transform', (d) -> d.gTrans)

      bloblet.append('rect')
        .attr('class', 'bloblet')
        .attr('x', (d) -> d.x )
        .attr('y', (d) -> d.y )
        .attr('rx', 10).attr('ry', 10)
        .attr('width', (d) -> d.width)
        .attr('height', (d) -> d.height)
        .attr('transform', (d) -> d.rectTrans)
        .style('cursor', 'move')
        .call(drag)

      bloblet.append('g')
        .attr('class', 'slider')
        .each((d) -> makeSlider(d3.select(this), d))



    makeSlider = (element, d)->
      element.attr('transform', (d) -> d.rectTrans)

      lHandle = element.append('rect')
        .attr('class', 'handle left')
        .attr('x', 10)
        .attr('y', 5)
        .attr('height', (d) -> d.height - 10)
        .attr('width', 5)
        .style('cursor', 'ew-resize')
        .style('fill', 'red')
        .call(dragHandle)

      rHandle = element.append('rect')
        .attr('class', 'handle right')
        .attr('x', (d) -> d.width - 10)
        .attr('y', 5)
        .attr('height', (d) -> d.height - 10)
        .attr('width', 5)
        .style('cursor', 'ew-resize')
        .style('fill', 'red')
        .call(dragHandle)

    move = ->
      rect = d3.select(this)
      rectTrans = rect.attr('transform')
      x = if rectTrans? then parseInt rectTrans[10..].split(',')[0] else 0
      y = if rectTrans? then parseInt rectTrans[10..].split(',')[1] else 0
      nX = x + d3.event.dx
      nY = y + d3.event.dy
      slider = d3.select(this.parentElement).select('.slider')
      rect
        .attr('transform', 'translate(' +nX+ ',' +nY+')')
      slider
        .attr('transform', 'translate(' +nX+ ',' +nY+')')



    drag = d3.behavior.drag().origin(-> {x:0, y:0}).on('drag', move)
    dragHandle = d3.behavior.drag()
      .origin((d) -> d)
      .on('dragstart', spawn)
      .on('drag', dragresize)
      .on('dragend', spawnSet)


    setAccountBlob = (balance)->
      blob =
        width: scope.lengthScale(balance)
        amount: balance
        y: 0
        x: 0
      blob.gTrans = 'translate(' + (blob.width/2 - chartParams.width/4) + ',0)'
      blob.rectTrans = 'translate(0,0)'
      blob.height = scope.areaScale(balance)/blob.width
      blob.scale = d3.scale.linear().domain([0,balance]).range([0,blob.width]).clamp(true)
      blob

    ##unused
    setBlobletPositions = (bloblets)->
      xMark = 0
      for blob, i in bloblets
         len = Math.sqrt(scope.areaScale(blob.value))
         blob.x = xMark
         blob.y = 0
         blob.w = len
         blob.h = len
         xMark += len + chartParams.margin.gap

    ##unused
    generateBloblets = (allocatable, defaultSize, n)->
      bloblets = ({value: defaultSize} for i in [1..n])
      remainder = allocatable % n
      if remainder isnt 0
        bloblets.push {value: remainder}
      return bloblets

    setLengthScale = (areaScale)->
      val = areaScale.domain()[1]
      pixels = Math.sqrt(areaScale.range()[1])*2
      d3.scale.linear().domain([0,val]).range([0,pixels])

    setAreaScale = (chartParams, allocatable, BucketsMaximaSum)->
      ratio = 0.1
      val = allocatable + BucketsMaximaSum
      drawnArea = ratio*chartParams.width*chartParams.height
      d3.scale.linear().domain([0,val]).range([0,drawnArea])

    getBucketMaximaSum = (buckets)->
      d3.sum(buckets, (b) -> b.maximum_cents )

    getDefaultAllocationSize = (allocatable, buckets)->
      int = Math.round(allocatable / buckets.length)
      digits = int.toString().length
      denominator = Math.pow(10, digits-1) / 2
      return Math.floor(int/denominator) * denominator

    getBucketUserAllocation = (bucket)->
      for a in bucket.allocations
        if a.user_id == User.getCurrentUser().id
          return a.amount

    formatBucketTimes = (bucket)->
      bucket.created_at_ago = Time.ago(bucket.created_at)
      if bucket.funded_at?
        bucket.funded_at_full = Time.full(bucket.funded_at)
      if bucket.cancelled_at?
        bucket.cancelled_at_full = Time.full(bucket.cancelled_at)
      bucket

    #load the buckets methods
    loadBucketsWithoutAllocations = ->
      Budget.getBudgetBuckets(scope.budget_id, $state.params.state).then (buckets)->
        return buckets
      , (error)->
        console.log error

    loadBucketsAllocations = (buckets)->
      deferred = $q.defer()
      promises = []
      angular.forEach buckets, (bucket)->
        promises.push Bucket.getBucketAllocations(bucket.id)
      #this respects the order we passed in so we are safe to foreach the buckets again
      $q.all(promises).then (allocations_array)->
        buckets_with_allocations = []
        for allocations, i in allocations_array
          buckets[i].color = ColorGenerator.makeColor(0.3,0.3,0.3,0,i * 1.25,4,177,65, i)
          buckets[i].allocations = allocations
          buckets[i].user_allocation = getBucketUserAllocation(buckets[i])
          buckets[i] = formatBucketTimes(buckets[i])
          buckets_with_allocations.push buckets[i]
          if i == buckets.length - 1
            scope.buckets = buckets_with_allocations
            return buckets_with_allocations

    setUserAllocations = (buckets_with_allocations)->
      user_allocations = []
      angular.forEach buckets_with_allocations, (bucket)->
        angular.forEach bucket.allocations, (allocation)->
          if allocation.user_id == User.getCurrentUser().id
            if allocation.amount > 0
              allocation.label = "#{bucket.name}"
              allocation.bucket_color = bucket.color
              user_allocations.push allocation
      scope.user_allocations = user_allocations
      return user_allocations

    addUnallocatedToUserAllocations = ()->
      scope.user_allocations.push {user_id: undefined, label: "Unallocated", amount: scope.unallocated, bucket_color: "#ececec" }
      scope.user_allocations

    setCollectionAllocationGlobals = (user_allocations)->
      User.getAccountForBudget($state.params.budget_id).then (account)->
        scope.account_balance = account.allocation_rights_cents
        scope.allocated = Budget.getUserAllocated(user_allocations)
        scope.allocatable = Budget.getUserAllocatable(scope.account_balance, scope.allocated)
        scope.unallocated = scope.allocatable - scope.allocated
        scope.defaultAllocationSize = getDefaultAllocationSize(scope.allocatable, scope.buckets)
        scope.bucketMaximaSum = getBucketMaximaSum(scope.buckets)
        scope.areaScale = setAreaScale(chartParams, scope.allocatable, scope.bucketMaximaSum)
        scope.lengthScale = setLengthScale(scope.areaScale)
        addUnallocatedToUserAllocations()
        return account
      , (error)->
        console.log error

    #load
    loadBucketsWithoutAllocations()
    .then(loadBucketsAllocations)
    .then(setUserAllocations) #takes bucktes
    .then(setCollectionAllocationGlobals) #takes user allocations
    .then ()->
      scope.buckets ||= []
      $rootScope.$broadcast("user-allocations-updated", {user_allocations: scope.user_allocations, buckets: scope.buckets})
      #force horiz graph to load
      $timeout ()->
        angular.forEach scope.buckets, (bucket)->
          $rootScope.$broadcast("bucket-allocations-updated", { bucket_allocations:bucket.allocations, bucket_id: bucket.id })

      blob = setAccountBlob(scope.account_balance)
      blobSet(d3.select('.blobG'), blob)
      b = $('.blobG')
      $compile(b.contents())(scope)



    console.log 'SCOPE', scope


    #scope mehods
    scope.getTotalBucketAllocations = (bucket)->
      Bucket.sumBucketAllocations(bucket)

    #events
    scope.$on 'current-user-bucket-allocation-update', (event, data)->
      user_allocations = setUserAllocations(scope.buckets)
      setCollectionAllocationGlobals(user_allocations).then ()->
        $rootScope.$broadcast("user-allocations-updated",{user_allocations: user_allocations, buckets: scope.buckets })
        for bucket in scope.buckets
          if bucket.id == data.bucket_id
            $rootScope.$broadcast("bucket-allocations-updated", { bucket_allocations: bucket.allocations, bucket_id: bucket.id })
            break

    #pushers
    $rootScope.channel.bind('allocation_updated', (response) ->
      if scope.buckets?
        response.amount = parseFloat(response.amount)
        for bucket, idx in scope.buckets
          #ignore for self
          if response.user_id == User.getCurrentUser().id
            break
          #get the bucket
          if response.bucket_id == bucket.id
            for allocation, i in bucket.allocations
              #match to user
              if allocation.user_id == response.user_id
                scope.buckets[idx].allocations[i].amount += response.amount * 100
          #maybe use this for user and others.
                $rootScope.$broadcast("bucket-allocations-updated", { bucket_allocations:scope.buckets[idx].allocations, bucket_id: scope.buckets[idx].id })
        scope.$apply()
    )

    #todo add other fields to the bucket
    #$rootScope.channel.bind('bucket_created', (response) ->
      #scope.$apply ()->
        #scope.buckets.unshift response.bucket
      #$rootScope.$broadcast("bucket-allocations-updated", { bucket_allocations:scope.buckets[i].allocations, bucket_id: scope.buckets[i].id })
    #)

    $rootScope.channel.bind('bucket_updated', (response) ->
      angular.forEach scope.buckets, (old_bucket, i)->
        if old_bucket.id == response.bucket.id
          response.bucket.allocations = old_bucket.allocations
          response.bucket.user_allocation = old_bucket.user_allocation
          response.bucket.color = old_bucket.color
          scope.$apply( ()->
            scope.buckets[i] = formatBucketTimes(response.bucket)
          )
          $rootScope.$broadcast("bucket-allocations-updated", { bucket_allocations:scope.buckets[i].allocations, bucket_id: scope.buckets[i].id })
    )

]
