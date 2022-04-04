class Player
  attr_reader :name, :mark

  @@first_player = true
  def initialize
    @@first_player ? (@name = "player1"; @mark = "X") : (@name = "player2"; @mark = "O")
    @@first_player = false
  end
end

class Game
  attr_reader :player1, :player2
  @@player1_turn = true # true => player1 ; false => player2

  def initialize(player1, player2)
    @playground = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @player1 = player1
    @player2 = player2
  end

  def display
    puts @playground[0..2].join(' | ')
    puts '---------'
    puts @playground[3..5].join(' | ')
    puts '---------'
    puts @playground[6..8].join(' | ')
  end

  def play_turn
    display
    puts "Pick a position"
    position = gets.chomp.to_i
    update_board(position)
    @@player1_turn != @@player1_turn
  end

  def update_board(position)
    pos_index = @playground.index(position)
    @@player1_turn ? (@playground[pos_index] = "X") : (@playground[pos_index] = "O")
    display
  end 

end

player1 = Player.new
player2 = Player.new
game = Game.new(player1, player2)
game.play_turn
