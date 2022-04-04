# TODO 
# Split main file into classes files

class Player
  attr_reader :name
  attr_accessor :score

  @@first_player = true
  def initialize
    puts "Enter player name"

    if @@first_player
      @name = gets.chomp
      @@first_player = false
    else
      @name = gets.chomp
    end

    @score = 0
  end
end

class Game
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @round_nbr = 1
  end

  def display_board
    puts ''
    puts @board[0..2].join(' | ')
    puts '---------'
    puts @board[3..5].join(' | ')
    puts '---------'
    puts @board[6..8].join(' | ')
    puts ''
  end

  def play_round
    @current_player = randomize_player
    puts "\n#{@current_player.name} go first"
    @board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

    turn = 0
    until victory? || turn >= 9
      play_turn
      turn += 1
    end
    finished_game
  end

  def randomize_player
    return [player1, player2].sample
  end

  def play_turn
    display_board
    position = get_input
    update_board(position)
    switch_player
  end

  def get_input
    puts "Pick a position #{@current_player.name}"
    position = gets.chomp
    @board.include?(position) ? (return position) : (puts 'Wrong input'; get_input)
  end

  def update_board(position)
    pos_index = @board.index(position)
    @current_player == player1 ? (@board[pos_index] = "X") : (@board[pos_index] = "O")
  end 

  def switch_player
    @current_player == player1 ? (@current_player = player2) : @current_player = player1
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
    display_board
    if victory?
      switch_player # Need it to 'revert to previous' player
      puts "#{@current_player.name} wins !! Congratulations!"
      update_score
      display_score
    else
      puts "It's a draw !"
    end

    replay
  end

  def update_score
    @current_player.score += 1
  end

  def display_score
    puts "#{player1.name}: #{player1.score} -- #{player2.name}: #{player2.score}"
  end

  def replay
    puts "Play another round ? (Y/N)"
    answer = gets.chomp
    if answer == 'Y'
      @round_nbr += 1
      puts "Let's go for round #{@round_nbr}"
      play_round
    elsif answer == 'N'
      puts "Bye"
      puts "Final score"
      display_score
    else
      puts "Wrong input" 
      replay
    end
  end
end

player1 = Player.new
player2 = Player.new
game = Game.new(player1, player2)
game.play_round
