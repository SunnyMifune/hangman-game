class Hangman
  def initialize
    @word = words.sample
    @lives = 7
    @word_teaser = ""

    @word.first.size.times do
      @word_teaser += "_ "
    end
  end

  def words
    [
      ["apple", "a kind of fruit"],
      ["violin", "an instrument"],
      ["elephant", "an animal"],
      ["crystal", "a beautiful rock"],
      ["cellphone", "you will bring it everyday and it can connect to the internet"],
    ]
  end

  def print_teaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser last_guess
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      #replace blank values with guessed letter if matches letter in word
      if letter == '_' && @word.first[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    if @lives > 0
    puts "Enter a letter"
    guess = gets.chomp

    #if letter is not part of the word than remove from letters array
    good_guess = @word.first.include? guess

      if guess == "exit"
        puts "Thank you for playing!"

        #if guess is longer than 1 letter
      elsif guess.length > 1
        puts "only guess 1 letter at a time please!"
          make_guess

      elsif good_guess
        puts "You are correct!"

        print_teaser guess

        if @word.first == @word_teaser.split.join
          puts "Congratulations... you have won this round!"
        else
          make_guess
        end
      else
        @lives -= 1
        puts "Wrong guess... you have #{@lives} lives left. Please try again!"
        make_guess
      end
    else
      puts "Game over!"
    end
  end

  def begin
  #ask user to enter a letter
    puts "New game started...your word is #{@word.first.size} characters long"
    puts "To exit game at any point type 'exit'"
    print_teaser

    puts "Clue: #{@word.last}"

    make_guess
  end
end

game = Hangman.new
game.begin
