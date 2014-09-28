class window.Card extends Backbone.Model

  initialize: (params) ->
    @set
      rank: ['K', 'A', '2', '3', '4', '5', '6', '7', '8', '9', 'aj', 'J', 'Q'][params.rank]
      color: ['black', 'red'][params.suit % 2]
      suit: ['Z', 'W', 'Y', 'X'][params.suit]
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['spades', 'diamonds', 'clubs', 'hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'King'
        when 1 then 'Ace'
        when 11 then 'Jack'
        when 12 then 'Queen'
        else params.rank

  flip: ->
    @set 'revealed', !@get 'revealed'
    @.trigger('flip')
    @
