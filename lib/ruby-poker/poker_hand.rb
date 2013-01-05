class PokerHand
  RANK_VALUES = {
    :high_card       => 0,
    :pair            => 1,
    :two_pair        => 2,
    :three_of_a_kind => 3,
    :straight        => 4,
    :flush           => 5,
    :full_house      => 6,
    :four_of_a_kind  => 7,
    :straight_flush  => 8
  }

  attr_reader :cards
  attr_reader :rank

  def initialize(cards)
    if cards.is_a? String
      cards = cards.split
    end
    @cards = cards.map { |c| c.is_a?(Card) ? c : Card.new(c) }

    raise ArgumentError, 'A poker hand must have at least one card' if @cards.length == 0

    for c in @cards
      raise ArgumentError, 'A poker hand cannot contain duplicates' if @cards.count { |c2| c.same? c2 } > 1
    end

    if @cards.length > 5
      @cards = @cards[0...5]
    end

    rankify
  end

  private

  def rankify
    @cards.sort!.reverse!
    values = @cards.map { |c| c.to_i }

    @rank =
      if is_straight and is_flush
        :straight_flush
      elsif values.each_cons(4).one? { |i| i.uniq.length == 1 }
        :four_of_a_kind
      elsif values.each_cons(3).one? { |i| i.uniq.length == 1 and (values - i).uniq.length == 1 }
        :full_house
      elsif is_flush
        :flush
      elsif is_straight
        :straight
      elsif values.each_cons(3).one? { |i| i.uniq.length == 1 }
        :three_of_a_kind
      elsif values.each_cons(2).count { |i, j| i == j } == 2
        :two_pair
      elsif values.each_cons(2).one? { |i, j| i == j }
        :pair
      else
        :high_card
      end
  end

  def is_flush
    suit = @cards.first.suit
    @cards.all? { |c| c.suit == suit }
  end

  def is_straight
    is_low_straight or @cards[0..5].each_cons(2).all? { |i, j| i.to_i == j.to_i + 1 }
  end

  def is_low_straight
    @cards.first.rank == :A and @cards.last.rank == :'2' and @cards[1..4].each_cons(2).all? { |i, j| i.to_i == j.to_i + 1 }
  end
end
