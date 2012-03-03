=begin
Part 2: Rock-Paper-Scissors
=end


class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end


#A
def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2
  player1, player1_strategy = game[0], game[0][1].upcase
  player2, player2_strategy = game[1], game[1][1].upcase
  legal_strategies = ['R','P','S']
  raise NoSuchStrategyError unless legal_strategies.include?(player1_strategy) && legal_strategies.include?(player2_strategy)
  wins = lambda do | strategy1, strategy2 |
      return (strategy1 == 'P' && strategy2 == 'R') ||
             (strategy1 == 'S' && strategy2 == 'P') ||
             (strategy1 == 'R' && strategy2 == 'S')
  end
  if (player1_strategy == player2_strategy)
    player1  
  elsif (wins.call(player1_strategy, player2_strategy))
    player1
  else
    player2
  end
end

game = [ [ "Armando", "P" ], [ "Dave", "S" ] ]
winner = rps_game_winner(game)
p winner


#B
def rps_tournament_winner(tournament)
  plays = Hash[*tournament.flatten].map { |player, strategy| [player, strategy] }
  while (plays.length > 1)
    next_plays = []
    plays.each_slice(2) { |game| next_plays << rps_game_winner(game) }
    plays = next_plays
  end
  plays[0]
end


tournament = [ [
                 [ ["Armando", "P"], ["Dave", "S"] ],
                 [ ["Richard", "R"], ["Michael", "S"] ]
               ],
               [
                 [ ["Allen", "S"], ["Omer", "P"] ],
                 [ ["David E.", "R"], ["Richard X.", "P"] ]
               ]
               ]
winner = rps_tournament_winner(tournament)
p winner