class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _([0...312]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13) % 4

  makePlayer: -> new Hand [ ], @

  makeDealer: -> new Hand [ ], @, true
