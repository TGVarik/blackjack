#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', playerHand = deck.makePlayer()
    @set 'dealerHand', deck.makeDealer()
    playerHand
    .on 'win bust stand', =>
      @trigger 'lock'
    .on 'bust', =>
      @endGame 'lose'
    .on 'win', =>
      @endGame 'win'
    .on 'stand', =>
      @playDealer()
    @playGame()
    return @

  playGame: ->
    deck = @get 'deck'
    playerHand = @get 'playerHand'
    playerHand.deal()
    @get 'dealerHand'
      .deal()
    playerHand.checkScore()
    return @

  endGame: (outcome) ->
    dealerHand = @get 'dealerHand'
    if not dealerHand.first().get 'revealed'
      dealerHand.first().flip()
#    if outcome is 'win'
#      alert 'You win!'
#    if outcome is 'lose'
#      alert 'You lose!'
#    if outcome is 'push'
#      alert 'You pushed!'
    @trigger 'endgame'
    return

  playDealer: ->
    # turn over that hidden card
    dealerHand = @get 'dealerHand'
    dealerHand.first().flip()
    loop
      dealerScore = Math.max.apply null, dealerHand.scores()
      if dealerScore > 21
        @endGame 'win'
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
          @endGame 'lose'
        else if dealerScore < playerScore
          @endGame 'win'
        else
          @endGame 'push'
        break
      else
        dealerHand.hit()

    return @
