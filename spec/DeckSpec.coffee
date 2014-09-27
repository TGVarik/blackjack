assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it "should give the last card from the deck", ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49
      hand.playable && (assert.strictEqual deck.last(), hand.hit())
      hand.playable && (assert.strictEqual deck.length, 48)


  describe 'bust', ->
    it "should announce a bust", ->
      busted = false
      hand.on 'bust', ->
        busted = true
      hand.add
        rank: 10
        suit: 1
      hand.add
        rank: 10
        suit: 1
    assert.strictEqual busted, true


# it should announce a bust
# it should announce a 21


# it should have a stand method
# it should announce a score
# tell dealer to start
