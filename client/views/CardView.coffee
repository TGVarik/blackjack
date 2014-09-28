class window.CardView extends Backbone.View

  className: 'card'

  t: ->
    w = 120


    fs = 26 * (w / 120)
    x = (fs / 2) + 4 * (w / 120)
    ry = fs + 4 * (w / 120)
    sw = 85 * (w / 120)
    h = 182 * (w / 120)
    br = 8 * (w / 120)
    m = 10 * (w / 120)
    rot = "rotate(180,#{w/2},#{h/2})"
    tra = "translate(#{x},#{ry})"
    sui = "translate(#{(w-sw)/2},#{(h-sw)/2})"
    tr = "<text class='rank' x='0px' y='0px'>#{@model.get 'rank'}</text>"
    tgu = "<g class='up' transform='#{tra}'>#{tr}</g>"
    tgd = "<g class='down' transform='#{rot},#{tra}'>#{tr}</g>"
    img = "<image class='#{@model.get 'suitName'}' width='#{sw}px' height='#{sw}px' xlink:href='img/#{@model.get 'suitName'}.svg' transform='#{sui}' />"
    bak = "<image class='card-back' width='#{w}px' height='#{h}px' xlink:href='img/card-back.svg' />"
    sty = "font-size: #{fs}px; border-radius: #{br}px; width: 100%; height: 100%;"
    @divstyle =
      "width": "#{w}px"
      "height": "#{h}px"
      "margin": "#{m}px"
      "border-radius": "#{br}px"
    @template = "<svg class='card-svg front #{@model.get 'color'}' style='#{sty}'>#{img}#{tgu}#{tgd}</svg>"
    @cardback = "<svg class='card-svg back' style='#{sty}'>#{bak}</svg>"

  # template: _.template 'url("img/cards/<%= rankName %>-<%= suitName %>.png")'

  initialize: ->
    @t()
    @$el.css @divstyle
    #@model.on 'change', => @render
    @model.on 'flip', (event) => @onFlip event
    @render()

  render: ->
    @$el.children().detach().end().html
    #if @model.get 'revealed'
      # @$el.css 'background-image', @template @model.attributes
    #  @$el.html @template
    #else
    #  @$el.html @cardback
    # @$el.css @divstyle
    @$el.html @template + @cardback
    @$el.addClass 'covered' unless @model.get 'revealed'

  onFlip: (event) ->
    if @$el.hasClass 'covered'
      @$el.removeClass 'covered'
    else @$el.addClass 'covered'