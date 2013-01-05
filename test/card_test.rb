require 'test_helper'

class TestCard < MiniTest::Unit::TestCase
  def test_initialize_with_nothing
    assert_raises(ArgumentError) do
      Card.new
    end
  end

  def test_initialize_with_string
    card = Card.new('As')
    assert_equal :A, card.rank
    assert_equal :s, card.suit

    card = Card.new('aS')
    assert_equal :A, card.rank
    assert_equal :s, card.suit

    card = Card.new('2c')
    assert_equal :'2', card.rank
    assert_equal :c, card.suit
  end

  def test_initialize_with_rank_and_suit_strings
    card = Card.new('A', 's')
    assert_equal :A, card.rank
    assert_equal :s, card.suit

    card = Card.new('a', 'S')
    assert_equal :A, card.rank
    assert_equal :s, card.suit

    card = Card.new('2', 'c')
    assert_equal :'2', card.rank
    assert_equal :c, card.suit
  end

  def test_initialize_with_rank_and_suit_symbols
    card = Card.new(:A, :s)
    assert_equal :A, card.rank
    assert_equal :s, card.suit

    card = Card.new(:a, :S)
    assert_equal :A, card.rank
    assert_equal :s, card.suit

    card = Card.new(:'2', :c)
    assert_equal :'2', card.rank
    assert_equal :c, card.suit
  end

  def test_initialize_with_invalid_rank
    assert_raises(ArgumentError) do
      Card.new('Xs')
    end
  end

  def test_initialize_with_invalid_suit
    assert_raises(ArgumentError) do
      Card.new('Ax')
    end
  end

  def test_initialize_with_invalid_single_argument
    assert_raises(ArgumentError) do
      Card.new('invalid')
    end

    assert_raises(ArgumentError) do
      Card.new(0)
    end
  end

  def test_to_string
    assert_equal 'As', Card.new('As').to_s
    assert_equal 'Td', Card.new('T', 'd').to_s
    assert_equal '3c', Card.new(:'3', :c).to_s
  end

  def test_comparing_ranks
    assert Card.new('As') > Card.new('Ks')
    assert Card.new('Ks') > Card.new('Qs')
    assert Card.new('Qs') > Card.new('Js')
    assert Card.new('Js') > Card.new('Ts')
    assert Card.new('Ts') > Card.new('9s')
    assert Card.new('9s') > Card.new('8s')
    assert Card.new('2s') < Card.new('3s')
    assert Card.new('As') == Card.new('Ac')
    assert Card.new('As') != Card.new('Ks')
    assert Card.new('As') >= Card.new('Ac')
    assert Card.new('As') >= Card.new('Ks')
    assert Card.new('2s') <= Card.new('2c')
    assert Card.new('2s') <= Card.new('3s')
  end

  def test_same_card
    assert Card.new('As').same?(Card.new('As'))
    refute Card.new('As').same?(Card.new('Ac'))
  end
end
