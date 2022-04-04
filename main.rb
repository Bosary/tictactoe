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
    @board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    @player1 = player1
    @player2 = player2
  end

  def display
    puts ''
    puts @board[0..2].join(' | ')
    puts '---------'
    puts @board[3..5].join(' | ')
    puts '---------'
    puts @board[6..8].join(' | ')
    puts ''
  end

  def play_round
    turn = 0
    until victory? || turn >= 9
      play_turn
      @@player1_turn = !@@player1_turn
      turn += 1
    end
    finished_game
  end

  def play_turn
    display
    puts "Pick a position"
    position = gets.chomp
    update_board(position)
  end

  def update_board(position)
    pos_index = @board.index(position)
    @@player1_turn ? (@board[pos_index] = "X") : (@board[pos_index] = "O")
  end 

  def victory?
    3.times do |i|
      # Check rows. Need to move index per 3 with each iteration
      if (@board[0 + 3*i] + @board[1 + 3*i]) == (@board[2 + 3*i] + @board[2 + 3*i])
        return true
      end

      # Check column. Need to move index per 1 with each iteration
      if (@board[0 + i] + @board[3 + i]) == (@board[6 + i] + @board[6 + i])
        return true
      end
    end

    # Check diagonals
    if (@board[0] + @board[4]) == (@board[8] + @board[8])
      return true
    end

    if (@board[2] + @board[4]) == (@board[6] + @board[6])
      return true
    end

    return false
  end

  def finished_game
    display
    if victory?
      @@player1_turn = !@@player1_turn # Need to 'revert to previous' turn
      @@player1_turn ? (puts "#{player1.name} Win !!") : (puts "#{player2.name} Win !!")
    else
      puts "It's a draw !"
    end
  end
end

player1 = Player.new
player2 = Player.new
game = Game.new(player1, player2)
game.play_round
