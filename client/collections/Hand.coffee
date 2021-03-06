class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add @deck.pop()
    scores = @scores()
    @checkScore()
    @last()

  checkScore: ->
    scores = @scores()
    lowest = 22
    for key of scores
      if scores[key] is 21
        @trigger "win"
        return @last()
      if scores[key] < lowest
        lowest = scores[key]
    if lowest > 21
      @trigger "bust"
    return

  stand: ->
    @trigger "stand"
    return

  deal: ->
    if @isDealer
      @reset [ @deck.pop().flip() , @deck.pop() ]
    else
      @reset [ @deck.pop() , @deck.pop() ]
    return

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
