class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="play-button" style="display: none">Play again</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .play-button": ->
      $ '.play-button'
        .hide()
      $ '.hit-button'
        .prop 'disabled', false
      $ '.stand-button'
        .prop 'disabled', false
      @model.playGame()

  initialize: ->
    @render()
    @model
    .on 'endgame', ->
      $ '.play-button'
       .show()
    .on 'lock', ->
      $ '.hit-button'
        .prop 'disabled', true
      $ '.stand-button'
        .prop 'disabled', true


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
