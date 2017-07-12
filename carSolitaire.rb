#o Author: Vincent Ball
class Card
  attr_accessor :number, :suit, :value

  #o Author: Vincent Ball
  #o Purpose: Initialize Card
  #o Inputs: number, suit, value
  def initialize(number, suit, value)
    @number = number
    @suit = suit
    @value = value
  end

  #o Author: Vincent Ball
  #o Purpose: to string for a card
  #o Outputs: card
  def to_s
    "#{@number} of #{@suit}"
  end

  #o Author: Vincent Ball
  #o Purpose: check if card value for two cards are equal
  #o Inputs: Card
  #o Outputs: Prints if equal or not
  def check_equal_value(card1 = Card.new(number, suit, value))
    card2 = Card.new(number, suit, value)
    if card1.value == card2.value
      puts "Equal value!"
    else
      puts "card 1 and card 2 do not have equal values"
    end
  end

  #o Author: Vincent Ball
  #o Purpose: check if card suit for two cards are equal
  #o Inputs: Card
  #o Outputs: Prints if equal or not
  def check_equal_suit(card1 = Card.new(number, suit, value))
    card2 = Card.new(number, suit, value)
    if card1.suit == card2.suit
      puts "Same suit!"
    else
      puts "card 1 and card 2 do not have the same suit"
    end
  end
end

class Deck
  attr_reader :cards
  RANKS = %w[Ace 2 3 4 5 6 7 8 9 10 J Q K]
  SUITS = %w[Spades Hearts Diamonds Clubs]

  #o Author: Vincent Ball
  #o Purpose: initialize deck
  #o Inputs: Card
  def initialize cards
    @deck = cards
  end

  #o Author: Vincent Ball
  #o Purpose: initialize deck
  #o Outputs: deck
	def initialize
		@deck = []
		SUITS.each do |suit|
			(RANKS.size).times do |i|
				@deck.push(Card.new(RANKS[i], suit, (i+1)))
			end
      @hand = []
      @discard = []
  end

  #o Author: Vincent Ball
  #o Purpose: check if two cards have same suit
  #o Outputs: true or false
  def same_suit?
    @deck.all? { |s| s.suit == @deck.first.suit }
  end

  #o Author: Vincent Ball
  #o Purpose: check if two cards have same value
  #o Outputs: true or false
  def same_value?
    @deck.all? { |a| a.value == @deck.first.value }
  end

  #o Author: Vincent Ball
  #o Purpose: check if two cards have same suit, different try
  def remove2?
    if @hand.at(@hand.length - 4).suit == @hand.at(@hand.length - 1).suit
      @hand.delete_at(@hand.length - 2)
      @hand.delete_at(@hand.length - 3)
      draw(2)
    else
      draw(1)
    end
  end

  #o Author: Vincent Ball
  #o Purpose: check if two cards have same value a different way
  #o Outputs: true or false
  def remove4?
    if @hand.at(@hand.length - 4).value == @hand.at(@hand.length - 1).value
      @hand.delete_at(@hand.length - 1)
      @hand.delete_at(@hand.length - 2)
      @hand.delete_at(@hand.length - 3)
      @hand.delete_at(@hand.length - 4)
      draw(4)
    else
      draw(1)
    end
  end

  #o Author: Vincent Ball
  #o Purpose: shuffle deck
	def shuffle
		@deck.shuffle!
	end

  #o Author: Vincent Ball
  #o Purpose: display deck
  #o Outputs: deck
  def display_deck
    puts "Current deck:"
    puts @deck
  end

  #o Author: Vincent Ball
  #o Purpose: display hand
  #o Outputs: hand
  def display_hand
    puts "Your hand:"
    puts @hand
  end

  #o Author: Vincent Ball
  #o Purpose: draw cards from deck
  #o Inputs: number_of_cards
  #o Outputs: cards drawn
  def draw(number_of_cards = 1)
    @hand.push(@deck.pop(number_of_cards))

    puts @hand.at(@hand.length - 4)
    puts @hand.at(@hand.length - 3)
    puts @hand.at(@hand.length - 2)
    puts @hand.at(@hand.length - 1)
  end

  #o Author: Vincent Ball
  #o Purpose: plays game
  #o Outputs: current hand
  def playGame
    score = 0
    deck = Deck.new
    deck.shuffle
    deck.shuffle
    deck.draw(4)

    #Tried, but doesn't work
    #deck.remove2?
    #deck.remove4?
    puts "Cards remaining in deck: #{deck.remaining}"
    puts "\n"

    while deck.remaining > 0
      cmd = gets
      if cmd.include? "D"
        puts deck.display_deck
      elsif cmd.include? "A"
          puts deck.display_hand
      elsif cmd.include? "X"
        puts "Exiting game..."
        exit
      elsif cmd.include? "L"
        file = File.open("Leaders.txt", 'r')
          while !file.eof?
            line = file.readline
            puts line
          end
      elsif cmd.include? "\n"
        size = @deck.length
        size -= 2
        puts deck.draw(1)

        #For testing. These worked, but couldn't
        #figure out how to implement on @hand
        #puts "\n"
        #card1 = Card.new(2, "Hearts", 2)
        #card2 = Card.new(2, "Hearts" ,2)
        #card1.check_equal_value(card2)
        #card1.check_equal_suit(card2)

        puts "\n"
        puts "Cards remaining in deck: #{deck.remaining}"
        puts "\n"
      end
    end
        score = 0
        time = Time.new
        deck.display_hand
        puts "Game over, out of cards"
        puts "Your score is: #{score}"
        puts "Enter a username: "
        username = gets
        file = File.open("Leaders.txt", "a")
        file.puts "Username: #{username}"
        file.puts "Score: #{score}"
        file.puts "Date: #{time.inspect}"
  end

  #o Author: Vincent Ball
  #o Purpose: gets deck size
  #o Outputs: deck size
	def remaining
    @deck.length
	end
end

puts "Enter X to exit game"
puts "Enter L to view leaderboard"
puts "Enter A (while in game) to view your hand"
puts "Enter D to display current deck"
puts "Enter P to play game"
puts "Enter H to play hidden game"
puts "Press ENTER to continue to next play"

#The "MAIN"
command = gets

if command.include? "P"
  deck = Deck.new
  deck.shuffle
  deck.playGame
  command = gets

elsif command.include? "X"
  puts "Exiting game"
  exit
elsif command.include? "H"
  deck2 = Deck.new
  deck2.shuffle
  deck2.playGame
elsif command.include? "D"
  deck3 = Deck.new
  deck3.shuffle
  deck3.display_deck
elsif command.include? "L"
  file = File.open("Leaders.txt", 'r')
    while !file.eof?
      line = file.readline
      puts line
    end
else
  deck = Deck.new
  deck.shuffle
  puts deck.draw(2)
  puts deck.remaining
end
end
