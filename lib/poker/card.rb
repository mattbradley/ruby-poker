class Card
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
    :T => 14,
  }

  attr_accessor rank, suit

  def initialize(*args)
    if args.size = 0 raise ArgumentError, 'Wrong number of arguments'
  end
end
