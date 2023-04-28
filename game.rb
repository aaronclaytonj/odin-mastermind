# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :player

  def initialize
    @board = Board.new
    @player = nil
  end

  def play
    game_setup
    make_guesses
    conclusion
  end

  def conclusion
    if board.winner
      puts "Congrats #{board.winner.name}, you got the right answer #{board.curr_guess}"
    else
      puts "You lose #{board.guesser.name}, the correct answer was #{board.answer}"
    end
  end

  def make_guesses
    board.update_guess(get_player_guess) until board.is_game_over
  end

  def get_player_guess
    # return %w[r o y g]
    puts "Please select 4 colors: #{board.colors}"
    input = []
    4.times do
      loop do
        guess = gets.chomp.strip[0]
        if board.valid_input?(guess)
          input << guess
          break
        else
          puts "Invalid, please select a VALID color: #{board.colors}"
        end
      end
    end

    input
  end

  def game_setup
    puts('Player 1 - Please enter your name!')
    @player = create_player('aaron')
    board.update_guesser(player)
  end

  def create_player(name)
    Player.new(name)
  end
end
