#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', playerHand = deck.dealPlayer()
    @set 'dealerHand', dealerHand = deck.dealDealer()
    playerHand
    .on 'bust', ->
      alert 'You Bust! :('
    .on 'win', ->
      alert 'You Won!'
    .on 'stand', ->
      @playDealer()
    , this
    return @

  playDealer: ->
    # turn over that hidden card
    dealerHand = @get 'dealerHand'
    dealerHand.first().flip()
    return @
