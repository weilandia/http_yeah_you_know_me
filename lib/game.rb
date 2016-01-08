class Game
  attr_reader :guess, :guess_counter
  attr_writer :answer

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

  def next_guess
    "<p>Total guesses: #{guess_counter}</p><p>Your last guess was #{last_guess} and #{high_low}"
  end

  def guess_input_form
    "</p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form>"
  end

  def high_low
    if last_guess == @answer then guess_win
    elsif last_guess < @answer then guess_too_low
    else guess_too_high end
  end

  def guess_win
    "it was the right number! You Win!<p><form action='/start_game' method='post'>
    <input type='Submit' value = 'Start New Game?'></input></form></p>"
  end

  def guess_too_low
    "it was too LOW.\nGuess again! #{
    guess_input_form}"
  end

  def guess_too_high
    "it was too HIGH.\nGuess again! #{
    guess_input_form}"
  end
end
