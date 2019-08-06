class Player
  def initialize(name)
    @name = name
    @losses = 0
    @letters = "GHOST"
  end

  def name
    @name
  end

  def losses=(l)
    @losses = l
  end

  def losses
    @losses
  end

  def guess
    p "It's player " + @name + "'s turn:"
    if @losses > 0
      p "Current letters: " + @letters[0..(@losses-1)]
    end
    p "Please guess a letter"
    input = gets.chomp
  end

  def alert_invalid_guess
    p "Invalid move"
  end
end