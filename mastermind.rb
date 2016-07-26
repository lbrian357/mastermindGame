module Generator
  def c_code
    colors = ['red','green','blue','yellow','brown','orange','black','white']
    c = {}
    colors.each {|i| c[(colors.index(i))] = i}
    c
  end

  def pick
    picks = []
    4.times {picks << rand(0...8)}
    picks
  end

  def color_to_index(string)
    array = string.split(' ')
    array.map { |i| c_code.invert[i] }
  end

  def index_to_color(array)
    a = []
    array.each { |i| a << c_code[i] }
    a.join(' ')
  end
end

class Game
  include Generator
  attr_accessor :picks, :win
  def initialize
    # @picks = pick 
    #
    @picks = [0, 0, 1, 1]
    @win = false
  end

  def start
    puts 'would you like to solve my mastermind puzzle or would you like me to solve yours? Enter \'solve\' or \'pose\''
    play_decision = gets.chomp
    if play_decision == 'solve'
      human_guess
    elsif play_decision == 'pose'
      human_picks
      comp_guess
    else
      puts 'I do not understand, please try again'
      start
    end
  end

  def human_picks
    puts 'give me an four colors to crack human: '
    h_p = gets.chomp
    self.picks = color_to_index(h_p)
  end

  def comp_guess
    keep = []
    for i in 1..12
      if win == true
        break
      end

      
      comp_guess = pick
      keep.uniq.each do |k|
        comp_guess.insert(rand(0..3), keep[k]).pop
      end

     guessing(comp_guess, i)

      comp_guess.each do |j|
        if picks.include?(j)
          keep << j
        end
      end

 
    end
  end 

  def human_guess
    #get user input on their guess
    for i in 1..12 do 
      if win == true
        break
      end

      print "\n please enter your guess separated by a space: "
      str_guess = gets.chomp 
      guess = color_to_index(str_guess)
      guessing(guess, i)
    end
  end

  def guessing(guess, i)
    puts "\n try number #{i}"
    if guess == picks
      self.win = true
      print 'You Win!'
    elsif i == 12
      print 'WRONG! You Lose!'

    else
      #check if user guess is included in answer
      p index_to_color(guess)
      p guess
      picks.uniq.each do |i|
        if picks.count(i) <= guess.count(i) 
          picks.count(i).times {print 'O'}
        else
          guess.count(i).times {print '0'}
        end
      end
      #guess.uniq.each do |i|
      #  picks.count(i).times {print 'O'}
      #end
      #guess.each { |i| print 'O' if picks.include?(i)}
      for i in 0...4 do
        print '@' if picks[i] == guess[i]
      end
    end
  end

  #print out clues if guesses were in answer
  #O for right color but wrong position
  #and @ for right color and right position
  #should print how many chances are left and keep history of guesses

  #when guess == picks and guesses_left > 0 you win


end



=begin
p picks
p guess
p guess_num
=end
