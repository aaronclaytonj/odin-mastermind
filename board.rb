# frozen_string_literal: true

class Board
  attr_reader :answer, :curr_guesses, :is_game_over, :colors, :curr_guess, :guesser, :winner

  COLORS = %w[red orange yellow green].freeze
  # yellow green blue violet
  MAX_GUESSES = 12

  def initialize
    @answer = []
    @guesser = nil
    @curr_guesses = 0
    @is_game_over = false
    @colors = COLORS
    @curr_guess = nil
    # 4.times do
    #   @answer << COLORS.sample.split('')[0]
    # end
    @answer = %w[o o r r]
    print "answer = #{answer}"
  end

  def valid_input?(inp)
    return false unless inp

    COLORS.any? { |color| color.split('')[0] == inp.downcase }
  end

  def update_guess(guess)
    @curr_guess = guess
    @curr_guesses += 1
    if did_win? || curr_guesses >= MAX_GUESSES
      @is_game_over = true
      nil
    else

      display_tries
      give_hint
    end
  end

  def display_tries
    print "\nYou guessed: #{curr_guess}\n"
    puts "You have #{MAX_GUESSES - curr_guesses} guesses left"
  end

  def did_win?
    return unless answer == curr_guess

    @winner = guesser
  end

  def give_hint
    # puts "give hint here"
    # colored key is both color and position
    temp_ans = answer.clone
    temp_guess = curr_guess.clone
    exact = 0
    same = 0
    temp_ans.each_with_index do |el, index|
      next unless el == temp_guess[index]

      temp_ans[index] = '*'
      temp_guess[index] = '*'
      exact += 1
    end

    temp_guess.each_with_index do |_el, index|
      next unless (temp_guess[index] != '*') && temp_ans.include?(temp_guess[index])

      remove = temp_ans.find_index(temp_guess[index])
      temp_ans[remove] = '?'
      temp_guess[index] = '?'
      same += 1
    end

    print "\nHints: "
    exact.times { print '* ' }
    same.times { print '? ' }
    puts
  end

  def update_guesser(guesser)
    @guesser = guesser
  end
end
