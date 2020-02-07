# require 'pry'

class Hand
  TEXT_VALUES = { 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }.freeze

  HAND_TYPES = {
    straight_flush?:    10,
    low_straight_flush?: 9,
    four_of_a_kind?:     8,
    full_house?:         7,
    flush?:              6,
    straight?:           5,
    low_straight?:       4,
    three_of_a_kind?:    3,
    two_pair?:           2,
    pair?:               1,
    high_card?:          0
  }.freeze

  # :rank_count is a hash in the form { rank => count };
  # key and value are integers.

  # :max_rank is the rank with the maximum count (not the highest rank).

  attr_reader :cards, :original_value, :ranks, :suits, :rank_count, :max_rank

  def initialize(cards)
    @original_value = cards
    @cards = map_cards(cards)
    @rank_count = ranks.group_by(&:itself).map { |k, v| [k, v.size] }.to_h
    @max_rank = @rank_count.key(@rank_count.values.max)
  end

  def hand_type
    HAND_TYPES.each { |key, value| return value if send(key) }
  end

  def ranks
    @cards.map(&:first)
  end

  def suits
    @cards.map(&:last)
  end

  # Sends an Enumerator::yielder object as the block argument. The block is
  # passed through to the Enumerator object in HandEnumerator::new. So,
  # yielder.yield yields card.first to the Enumerator parent object of this
  # object, thanks to passing this block to Enumerator's #initialize method
  # (see HandEnumerator#initialize).
  def to_enum
    HandEnumerator.new(self) do |yielder|
      @cards.each do |card|
        yielder.yield card.first
      end
    end
  end

  private

  def straight_flush?
    flush? && straight?
  end

  def low_straight_flush?
    flush? && low_straight?
  end

  def four_of_a_kind?
    4 == max_count
  end

  def full_house?
    3 == max_count && 2 == uniq_ranks
  end

  def flush?
    1 == suits.uniq.size
  end

  def straight?
    5 == uniq_ranks && 4 == ranks.max - ranks.min
  end

  # If ace is 14, low straight adds up to 28.
  def low_straight?
    5 == uniq_ranks && ranks.include?(14) && 28 == ranks.sum
  end

  def three_of_a_kind?
    3 == max_count && 3 == uniq_ranks
  end

  def two_pair?
    2 == max_count && 3 == uniq_ranks
  end

  def pair?
    4 == uniq_ranks
  end

  def high_card?
    true
  end

  # Largest number of cards of equal rank, e.g. 3 in a full house
  def max_count
    ranks.group_by(&:itself).values.max_by(&:size).size
  end

  # Count of the unique ranks in a hand.
  def uniq_ranks
    ranks.uniq.size
  end

  # Maps input to the format [[rank, suit], [...]], where rank is an
  # integer between 2 and 14; sorts the cards in descending order
  # (as required by #high_cards).
  def map_cards(cards)
    cards.map(&:chars).map do |(rank, suit)|
      [rank.to_i.zero? ? TEXT_VALUES[rank] : rank.to_i, suit]
    end.sort.reverse!
  end
end

class HandEnumerator < Enumerator
  attr_reader :hand

  # Sends the block passed in to HandEnumerator::new to Enumerator's
  # #initialize method. The enumerator then uses the block to perform
  # its iterations.
  def initialize(hand, &block)
    @hand = hand
    super(block)
  end
end

class Poker
  TIEBREAKERS = {
    10 => :straights,
    9  => :no_tiebreaker,
    8  => :dupes_more_than_pair,
    7  => :dupes_more_than_pair,
    6  => :high_cards,
    5  => :straights,
    4  => :no_tiebreaker,
    3  => :dupes_more_than_pair,
    2  => :two_pairs,
    1  => :pairs,
    0  => :high_cards
  }.freeze

  attr_reader :hands

  def initialize(hands)
    @hands = hands.map { |hand| Hand.new(hand) }
  end

  def best_hand
    max_hand_type = @hands.max_by(&:hand_type).hand_type
    best_hands = @hands.select { |hand| hand.hand_type == max_hand_type }
    best_hands = send(TIEBREAKERS[best_hands[0].hand_type], best_hands) if
      best_hands.size > 1
    # Wraps single hand in an array, #flatten removes extra array level if
    # there are multiple best hands
    [best_hands].flatten.map(&:original_value)
  end

  private

  def straights(hands)
    high_card = hands.map { |hand| hand.ranks.max }.max
    hands.select { |hand| hand.ranks.max == high_card }
  end

  # Low straights
  def no_tiebreaker(hands)
    hands
  end

  # Fours, full house, threes (Since there can't be more than one set of the
  # highest group of three or more, we don't have to find the max rank and
  # select the hands that have it, as we have to do with pairs or two pairs.)
  def dupes_more_than_pair(hands)
    hands.max_by(&:max_rank)
  end

  def pairs(hands)
    top_hands = top_high_pairs(hands)
    return high_cards(top_hands) if top_hands.size > 1
    top_hands
  end

  def two_pairs(hands)
    top_hands = top_high_pairs(hands)
    top_hands = top_low_pairs(top_hands) if top_hands.size > 1
    return high_cards(top_hands) if top_hands.size > 1
    top_hands
  end

  # Used by #pairs and #two_pairs. Since there can be more than one hand with
  # a pair of the same rank, we have to find the highest ranked pair first and
  # then select the hands that have it.
  def top_high_pairs(hands)
    top_pair = hands.map(&:max_rank).max
    hands.select { |hand| hand.max_rank == top_pair }
  end

  # Used by #two_pairs
  def top_low_pairs(hands)
    top_low_pair_rank = hands.map do |hand|
      hand.rank_count.select { |_, v| 2 == v }.min[0]
    end.max
    hands.select do |hand|
      hand.rank_count.key?(top_low_pair_rank)
    end
  end

  # Used by high card, flush, and pair or two pair hands resolved with kickers.

  # Hands are assumed to be sorted in reverse order. Converts each hand to a
  # HandEnumerator object. Iterates enumerators simultaneously (HandEnumerator
  # yields a single card's rank on each iteration), throwing out any hand(s)
  # whose current card doesn't match the current top card. Returns as an array
  # the #hand attribute of each HandEnumerator object remaining upon exiting
  # the iteration loop.

  def high_cards(hands)
    hand_enums = hands.map(&:to_enum)
    loop do
      max_rank = hand_enums.map(&:peek).max
      hand_enums.delete_if { |enum| enum.peek != max_rank }
      hand_enums.each(&:next)
    end
    hand_enums.map(&:hand)
  end
end

# full_of_4_by_9 = %w(4H 4S 4D 9S 9D)
# full_of_5_by_8 = %w(5H 5S 5D 8S 8D)
# game = Poker.new([full_of_4_by_9, full_of_5_by_8])
# p game.hands.map(&:original_value)
# p game.best_hand
# puts

# high_of_8 = %w(4S 5H 6S 8D 2H)
# high_of_queen = %w(2S 4H 6S 3D 8H)
# game = Poker.new([high_of_8, high_of_queen])
# p game.hands.map(&:original_value)
# p game.best_hand
# puts

# spade_straight_to_9 = %w(9S 8S 7S 6S 5S)
# diamond_straight_to_9 = %w(9D 8D 7D 6D 5D)
# three_of_4 = %w(4D 4S 4H QS KS)
# hands = [spade_straight_to_9, diamond_straight_to_9, three_of_4]
# game = Poker.new(hands)
# p game.hands.map(&:original_value)
# p game.best_hand
# puts

# three_of_4 = %w(4S 5H 4S 8D 4H)
# straight_to_5 = %w(4S AH 3S 2D 5H)
# game = Poker.new([three_of_4])
# p game.hands.map(&:original_value)
# p game.best_hand
# puts

game = Poker.new([%w(KC KD 7S 7C 3D), %w(KS KH 8H 8D 2H), %w(3H AD 4D 8C 4C)])
p game.hands.map(&:original_value)
p game.best_hand
puts

# three_of_4 = %w(4S 5H 4S 8D 4H)
# straight_to_5 = %w(4S AH 3S 2D 5H)
# game = Poker.new([three_of_4, straight_to_5])
# p game.hands.map(&:original_value)
# p game.best_hand
# puts

# square_of_2 = %w(2S 2H 2S 8D 2H)
# square_of_5 = %w(4S 5H 5S 5D 5H)
# game = Poker.new([square_of_2, square_of_5])
# p game.hands.map(&:original_value)
# p game.best_hand
# puts
