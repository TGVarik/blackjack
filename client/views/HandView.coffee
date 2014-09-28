class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  # template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'remove reset', => @render()

    @collection.on 'add', (card) =>
      @$el.append new CardView(model: card).$el
    @render()

  render: ->
    @$el.children().detach()
    # @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    # @$('.score').text @collection.scores()[0]

