class Game
  attr_reader :guess, :answer, :guess_counter

  def initialize
    @answer = rand(1..10)
    @guess_counter = 0
    @guess = []
  end

  def guess_tracker(guess)
    @guess_counter += 1
    @guess << guess.to_i
  end

  def last_guess
    @guess[-1].to_i
  end


  def high_low
    if last_guess == @answer
      "#{last_guess} was the right number! You Win!"
    elsif last_guess < @answer
      "it was too LOW.\nGuess again!"
    elsif last_guess > @answer
      "it was too HIGH.\nGuess again!"
    end
  end
end
