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
      @.get 'playerHand'
        .off 'stand'
      @playDealer()
    , this
    return @

  playDealer: ->
    # turn over that hidden card
    dealerHand = @get 'dealerHand'
    dealerHand.first().flip()
    loop
      dealerScore = Math.max.apply null, dealerHand.scores()
      if dealerScore > 21
        alert 'You Win!!!'
        break
      playerScore = @get 'playerHand'
        .scores();
      if playerScore[1]?
        if playerScore[1] > 21
          playerScore = playerScore[0]
        else
          playerScore = playerScore[1]
      else
        playerScore = playerScore[0]
      if dealerScore > 16
        if dealerScore > playerScore
          alert 'You Lose! :('
        else if dealerScore < playerScore
          alert 'You Win!!!'
        else
          alert 'You Pushed :/'
        break
      else
        dealerHand.hit()

    return @
