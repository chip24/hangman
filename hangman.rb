# Hangman Game

class Hangman

    @@turn_count = 0

    def choose_word()
        f = File.open("google-10000-english-no-swears.txt")
        @pick = f.select {|w| w.size > 4 && w.size <13}.sample
        puts @pick
        @pick_length = @pick.length 
        puts @pick_length
        f.close
    end

    def initial_display()
        puts "Your word has #{@pick_length} letters."
        puts "_" * @pick_length
        
    end

    def player_guess()
        puts "Choose a letter from A to Z."
        input = gets.chomp 
        until input.count("a-zA-Z") == 0 and input.count == 1
            puts "Make sure you have only entered a single  letter between A and Z."
            input = gets.chomp
            




