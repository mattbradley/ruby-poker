class Card
  include Comparable

  SUITS = [:s, :h, :d, :c]
  RANKS = [:'2', :'3', :'4', :'5', :'6', :'7', :'8', :'9', :T, :J, :Q, :K, :A]
  RANK_VALUES = {
    :'2' => 2,
    :'3' => 3,
    :'4' => 4,
    :'5' => 5,
    :'6' => 6,
    :'7' => 7,
    :'8' => 8,
    :'9' => 9,
    :T => 10,
    :J => 11,
    :Q => 12,
    :K => 13,
    :A => 14,
  }

  attr_accessor :rank, :suit

  def initialize(*args)
    raise ArgumentError, 'Wrong number of arguments' if args.size == 0

    if args.size == 1
      str = args.first
      raise ArgumentError, 'Single argument must be a string' if not str.is_a? String
      raise ArgumentError, 'String argument must have a length of two' if not str.length == 2
      @rank = str[0].upcase.to_sym
      @suit = str[1].downcase.to_sym
    else
      @rank = args[0].upcase.to_sym
      @suit = args[1].downcase.to_sym
    end

    raise ArgumentError, "'#{@rank}' is an invalid rank" if not RANKS.include? @rank
    raise ArgumentError, "'#{@suit}' is an invalid suit" if not SUITS.include? @suit
  end

  def to_i
    RANK_VALUES[@rank]
  end

  def to_s
    @rank.to_s + @suit.to_s
  end

  def <=>(another_card)
    RANK_VALUES[@rank] <=> RANK_VALUES[another_card.rank]
  end
  
  def same?(another_card)
    @rank == another_card.rank and @suit == another_card.suit
  end
end
