class Game
  attr_reader :guess, :answer, :guess_counter

  def initialize
    @answer = rand(1..9)
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

  def start
    "Guess a one digit number:<p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form></p>"
  end

  def game_path
    "<p>Total guesses: #{guess_counter}</p><p>Your last guess was #{last_guess} and #{high_low}"
  end

  def win
    "it was the right number! You Win!<p><form action='/start_game' method='post'>
    <input type='Submit' value = 'Start New Game?'></input></form></p>"
  end

  def guess_input_form
    "</p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form>"
  end

  def high_low
    if last_guess == @answer
      win
    elsif last_guess < @answer
      "it was too LOW.\nGuess again! #{
      guess_input_form}"
    elsif last_guess > @answer
      "it was too HIGH.\nGuess again!#{
      guess_input_form}"
    end
  end
end
