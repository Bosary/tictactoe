class Player
  attr_reader :name, :mark

  @@first_player = true
  def initialize
    @@first_player ? (@name = "player1"; @mark = "X") : (@name = "player2"; @mark = "O")
    @@first_player = false
  end
end