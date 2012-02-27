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

  def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2

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
    it "should only allow 2 players" do
      game_of_2 = [ [ "Armando", "P" ], [ "Dave", "S" ] ]
      expect { @hw1.rps_game_winner(game_of_2) }.to_not raise_error(WrongNumberOfPlayersError)
      
      game_of_1 = [ [ "Armando", "P" ] ]
      expect { @hw1.rps_game_winner(game_of_1) }.to raise_error(WrongNumberOfPlayersError)

      game_of_3 = [ [ "Armando", "P" ], [ "Dave", "S" ], [ "Joel", "R" ] ]
      expect { @hw1.rps_game_winner(game_of_3) }.to raise_error(WrongNumberOfPlayersError)
    end
  end

end
