require 'test_helper'

class TestPokerHand < MiniTest::Unit::TestCase
  def test_initialize_accepts_an_array_of_cards
    cards = [Card.new('As'), Card.new('Ac'), Card.new('Ah')]
    assert_equal cards, PokerHand.new(cards).cards
  end

  def test_initialize_accepts_an_array_of_strings
    cards = [Card.new('As'), Card.new('Ac'), Card.new('Ah')]
    assert_equal cards, PokerHand.new(['As', 'Ac', 'Ah']).cards
  end

  def test_initialize_accepts_a_string
    cards = [Card.new('As'), Card.new('Ac'), Card.new('Ah')]
    assert_equal cards, PokerHand.new('As Ac Ah').cards
  end

  def test_initialize_checks_for_duplicate_cards
    assert_raises(ArgumentError) do
      PokerHand.new(['As', 'As', 'Ac'])
    end
  end

  def test_hand_is_at_least_one_card
    assert_raises(ArgumentError) do
      PokerHand.new([])
    end
  end

  def test_hand_is_at_most_five_cards
    assert PokerHand.new(['As', 'Ac', 'Ad', 'Ah', 'Ks', 'Kc']).cards.length <= 5
  end

  def test_high_card
    assert_equal :high_card, PokerHand.new('As Tc 9c 8c 7c').rank
  end

  def test_pair
    assert_equal :pair, PokerHand.new('As Ac Tc 9c 8c').rank
  end

  def test_two_pair
    assert_equal :two_pair, PokerHand.new('As Ac Ts Tc 9c').rank
  end

  def test_three_of_a_kind
    assert_equal :three_of_a_kind, PokerHand.new('As Ac Ah Tc 9c').rank
  end

  def test_straight
    assert_equal :straight, PokerHand.new('Tc 9c 8c 7c 6s').rank
    assert_equal :straight, PokerHand.new('As 2s 3s 4s 5h').rank
  end

  def test_flush
    assert_equal :flush, PokerHand.new('Tc 9c 8c 7c 5c').rank
  end

  def test_full_house
    assert_equal :full_house, PokerHand.new('As Ac Ah Tc Ts').rank
  end

  def test_four_of_a_kind
    hand_rank = PokerHand.new('As Ac Ah Ad Ts').rank
    assert_equal :four_of_a_kind, hand_rank
  end

  def test_straight_flush
    assert_equal :straight_flush, PokerHand.new('Tc 9c 8c 7c 6c').rank
    assert_equal :straight_flush, PokerHand.new('As 2s 3s 4s 5s').rank
  end
end
