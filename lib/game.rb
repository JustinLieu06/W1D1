require_relative "player"
require 'set'

class Game
  def initialize
    # @player_1 = Player.new("one")
    # @player_2 = Player.new("two")
    @players = []
    # @current_player = @player_1
    # @previous_player = @player_2
    @fragment = ""
    file = File.open("dictionary.txt")
    @dictionary = file.readlines.map(&:chomp).to_set
  end

  def play_round
    p "Current fragment: " + @fragment
    take_turn(@current_player)
    next_player!
  end

  def run
    p "How many players are there?"
    input = gets.chomp.to_i
    #@players = Array.new(input) {Player.new("")}
    (0...input).each do |i|
      p "Enter player #{i+1} name"
            n = gets.chomp
      @players << Player.new(n)
    end
    @current_player = @players[0]
#    while @player_1.losses < 5 && @player_2.losses < 5
    while @players.count{|p| p.losses < 5} > 1
        play_round
    end
    (0...input).each do |i|
      p "#{@players[i].name} wins!" if @players[i].losses < 5
    end
  end

  def current_player
    @current_player
  end

  def previous_player
    @previous_player
  end

  def next_player!
    (0...@players.length).each do |i|
      if @current_player == @players[i]
        @previous_player = @players[i]
        @current_player = @players[(i+1) % @players.length]
        break
      end
    end
  end

  def take_turn(player)
    str = player.guess
    while !valid_play?(str)
        p "Current fragment: " + @fragment
        player.alert_invalid_guess
        player.losses = player.losses + 1
        return if player.losses >= 5
        str = player.guess
    end
    @fragment += str
    
  end

  def valid_play?(string)
    @dictionary.any? { |s| s.include?(@fragment + string)}
  end

end

game = Game.new
game.run
