require 'pry'

module Display
  def colorize(num)
    {
    '1' => "\e[101m   1   \e[0m",
    '2' => "\e[102m   2   \e[0m",
    '3' => "\e[103m   3   \e[0m",
    '4' => "\e[104m   4   \e[0m",
    '5' => "\e[105m   5   \e[0m",
    '6' => "\e[106m   6   \e[0m",
    }[num]
  end
  
  def pegs(key)
    {
    '*' => "\e[91m \u2B24 \e[0m",
    '&' => "\e[90m \u2B24 \e[0m",
    }[key]
  end

  def print_code (arr, turns)
    print "Guess ##{turns}  "
    arr.each do |x| 
      print colorize(x)
    end
  end

  def print_clues(exact_matches, color_matches)
    print " Clue Pegs: " 
    exact_matches.times { print pegs('*') }
    color_matches.times { print pegs('&') }
    puts
  end

end
class GamePlay
  include Display
  attr_reader :exact_matches, :color_matches

  def initialize
    @turns = 1
    computer = Computer.new
    player = Player.new
    computer.createCode
    play(player, computer)
  end

  def play(player, computer)
    while @turns <= 12
      turns(computer, player)
      break if win?(computer.secret_code, player.player_code, @turns)
      @turns += 1
    end

    if @turns == 12
      puts "You failed to break the code!"
      play_again?
    end
  end

  def turns(computer, player)
    player.get_guess(@turns)
    compare(computer.secret_code, player.player_code)
    print_clues(@exact_matches, @color_matches)
  end

  def compare(code, guess)
    temp_code = code.clone
    temp_guess = guess.clone
    @exact_matches = exact_match(temp_code, temp_guess)
    @color_matches = color_match(temp_code, temp_guess)
  end

  #Find exact color and position matches
  def exact_match(code, guess)
    exact = 0

    code.each_with_index do |item, index|
       if item == guess[index]
        exact += 1
        code[index] = 'x'
        guess[index] = 'x'
       end
    end
    exact 
  end

  #Find color matches
  def color_match(code, guess)
    color_match = 0

    code.each_with_index do |item, index|
      if item != 'x' && code.include?(guess[index])
       color_match += 1
      end
    end
    color_match  
  end 

  #Check if code has been guessed
  def win?(code, guess, turns)
    if code == guess
      if turns == 1
        puts "Congratulations! You broke the secret code in #{turns} move!"
        play_again?
        return true
      else
        puts "Congratulations! You broke the secret code in #{turns} moves!"
        play_again?
        return true
      end
    end
  end

  #Ask user if they want to play again
  def play_again?
    answer = ""
    while answer != "Y" && answer != "N"
      puts "Play again? Y/N"
      answer = gets.chomp
      answer.upcase
    end
    if answer == "Y" 
      game = GamePlay.new
    elsif answer == "N"
      exit
    end
  end

end

class Computer
  include Display

  attr_reader :secret_code
  
  def initialize
    
  end
  
  #Create an array of four random colors
  def createCode
    arr = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @secret_code = arr.map(&:to_s)
    #DELETE AFTER TESTING
    #print @secret_code
  end
end

class Player
  include Display
  attr_accessor :player_code

  def initialize
    @player_code = []
  end

  #Get guess from player, check to make sure it's valid
  def get_guess(turns)
    puts "Please type in four numbers between 1 and 6 to guess the code: "
    @guess = gets.chomp
    while !@guess.match(/^[1-6]{4}$/)
      puts "Invalid input. Please enter four numbers between 1 and 6 [for example: 1234]."
      @guess = gets.chomp
    end
    @player_code = @guess.to_s.split("")
    print_code(@player_code, turns)
  end

end


game = GamePlay.new
