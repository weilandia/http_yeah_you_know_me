require 'minitest/autorun'
require 'minitest/pride'
require 'game'
require 'test_helper'

class GameTest < Minitest::Test
  def test_game_can_intialize
    game = Game.new
    assert_equal 0, game.guess_counter
    assert_equal [], game.guess
  end

  def test_game_counter_functions
    game = Game.new
    game.guess_tracker(4)
    assert_equal 1, game.guess_counter
    game.guess_tracker(6)
    assert_equal 2, game.guess_counter
  end

  def test_last_guess_funtions
    game = Game.new
    game.guess_tracker(4)
    game.guess_tracker(5)
    game.guess_tracker(6)
    game.guess_tracker(7)
    assert_equal 7, game.last_guess
  end

  def test_game_can_start
    game = Game.new
    assert_equal "Guess a one digit number:<p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form></p>", game.start
  end

  def test_game_goes_to_next_guess
    game = Game.new
    game.guess_tracker(5)
    guess = game.next_guess.split[6]
    assert_equal "5", guess
  end

  def test_guess_input_form
    game = Game.new
    assert_equal "</p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form>", game.guess_input_form
  end

  def test_guess_win
    game = Game.new
    game.guess_tracker(5)
    game.answer = 5
    assert_equal "it was the right number! You Win!<p><form action='/start_game' method='post'>
    <input type='Submit' value = 'Start New Game?'></input></form></p>", game.high_low
  end

  def test_guess_too_low
    game = Game.new
    game.guess_tracker(3)
    game.answer = 5
    assert_equal  "it was too LOW.
Guess again! </p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form>", game.high_low
  end

  def test_guess_too_high
    game = Game.new
    game.guess_tracker(3)
    game.answer = 2
    assert_equal  "it was too HIGH.
Guess again! </p><form action='/game' method='post'>
    <input type='textarea' name='guess'></input>
    <input type='Submit'></input></form>", game.high_low
  end
end
