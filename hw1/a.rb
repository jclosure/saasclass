require 'rspec'



class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end


class Hw1

  def palindrome?(string)
    words = string.downcase.gsub(/[^\w]+/, '')
    words == words.reverse
  end

  def count_words(string)
    freqs = Hash.new(0)
    list = string.downcase.scan(/\w+/)
    list.each { |word| freqs[word] += 1 }
    freqs
  end

  def wins?(strategy1, strategy2)
    (strategy1 == 'P' && strategy2 == 'R') ||
      (strategy1 == 'S' && strategy2 == 'P') ||
      (strategy1 == 'R' && strategy2 == 'S')
  end

  def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    player1, player1_strategy = game[0], game[0][1].upcase
    player2, player2_strategy = game[1], game[1][1].upcase
    legal_strategies = ['R','P','S']
    raise NoSuchStrategyError unless legal_strategies.include?(player1_strategy) && legal_strategies.include?(player2_strategy)
    if (self.wins?(player1_strategy, player2_strategy))
      player1
    else
      player2
    end
  end

  def rps_tournament_winner(tournament)

    plays = Hash[*tournament.flatten].map { |player, strategy| [player, strategy] }

    while (plays.length > 1)
      next_plays = []
      plays.each_slice(2) { |game| next_plays << self.rps_game_winner(game) }
      plays = next_plays
    end
    
    plays[0]
    
  end

end




describe Hw1, "Ruby calisthenics" do

  before :all do
    @hw1 = Hw1.new
  end

  describe "palidrome? behaviors" do
    it "should positively identify a palindrome" do
      string = "Madam, I'm Adam!"
      @hw1.palindrome?(string).should == true
    end
    it "should not positively identify a nonpalindrome as a palindrome" do
      string = "Madam, I'm a Monkey's Uncle!"
      @hw1.palindrome?(string).should == false
    end
  end

  describe "count_words behavior" do
    it "should count the case insensitive occurrences of each word in a string" do
      string = "A man, a plan, a canal -- Panama"
      @hw1.count_words(string).should == {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
    end
  end

  describe "rps game behaviors" do
    it "should only allow 2 players per game" do
      game_of_2 = [ [ "Armando", "P" ], [ "Dave", "S" ] ]
      expect { @hw1.rps_game_winner(game_of_2) }.to_not raise_error(WrongNumberOfPlayersError)

      game_of_1 = [ [ "Armando", "P" ] ]
      expect { @hw1.rps_game_winner(game_of_1) }.to raise_error(WrongNumberOfPlayersError)

      game_of_3 = [ [ "Armando", "P" ], [ "Dave", "S" ], [ "Joel", "R" ] ]
      expect { @hw1.rps_game_winner(game_of_3) }.to raise_error(WrongNumberOfPlayersError)
    end

    it "should allow only legal strategies" do
      game_with_legal_strategy = [ [ "Armando", "R" ], [ "Dave", "S" ] ]
      expect { @hw1.rps_game_winner(game_with_legal_strategy) }.to_not raise_error(NoSuchStrategyError)

      game_with_illegal_strategy = [ [ "Armando", "X" ], [ "Dave", "S" ] ]
      expect { @hw1.rps_game_winner(game_with_illegal_strategy) }.to raise_error(NoSuchStrategyError)

    end

    it "should enforce that R beats S" do
      player1 = [ "Armando", "R" ]
      player2 = [ "Dave", "S" ]
      game = [ player1, player2 ]
      @hw1.rps_game_winner(game).should equal player1
    end

    it "should enforce that S beats P" do
      player1 = [ "Armando", "P" ]
      player2 = [ "Dave", "S" ]
      game = [ player1, player2 ]
      @hw1.rps_game_winner(game).should equal player2
    end

    it "should enforce that P beats R" do
      player1 = [ "Armando", "P" ]
      player2 = [ "Dave", "R" ]
      game = [ player1, player2 ]
      @hw1.rps_game_winner(game).should equal player1
    end

    it "should support a tournament at the end of which, there is a single winnder" do
      tournament = [ [
                       [ ["Armando", "P"], ["Dave", "S"] ],
                       [ ["Richard", "R"], ["Michael", "S"] ],
                     ],
                     [
                       [ ["Allen", "S"], ["Omer", "P"] ],
                       [ ["David E.", "R"], ["Richard X.", "P"] ]
                     ]
                     ]

      @hw1.rps_tournament_winner(tournament).should == ["Richard", "R"]

    end
  end

end
