# A Hangman game made with classes in the Ruby language
require "yaml"

class Game
    # open the dictionary and chose a random word between 5 and 12 characters
    
    f = File.open("google-10000-english-no-swears.txt")
    pick = f.select {|w| w.size > 4 && w.size <13}.sample
    puts pick
    #p pick
    #puts pick.length
    @@pick_minus_newline = pick.strip()
    #p @@pick_minus_newline
    @@pick_array = @@pick_minus_newline.split(//)
    #p @@pick_array
    @@pick_length = @@pick_minus_newline.length
    puts @@pick_length
    f.close
     
    @@guess_array = []
    @@wrong_guess_array = []
    @@turn_count = 0

    puts "Your word has #{@@pick_length} letters."

    # show underscores and blanks to represent the letters in the word
    @@board = "_ " * @@pick_length
    puts @@board

    @@board_minus_newline = @@board.strip()

    @@board_array = @@board_minus_newline.split(" ")
    #p @@board_array

    # ask the player to guess a single letter
    def player_guess()
        puts "\nChoose a letter from A to Z or type SAVE to save your game."
        @input = gets.chomp 
        if @input == "SAVE"
            save_game(Game)
        else
            until @input.match("[a-zA-Z]") && @input.length == 1 && @@guess_array.include?(@input) == false
            puts "Make sure you are entering a single letter between A and Z and that the letter has not yet been guessed."
            @input = gets.chomp
            end
        
        @@guess_array << @input
        @@turn_count += 1
        end
    end

   
        

    # loop through an array of the correct letters and find if the player's guess matches any of them
    def match()
        @@pick_array.each_with_index do |element,idx|
            #p element, idx
        
            if element == @input
                #puts element
                @@board_array[idx] = element
            end        
            
        end
       
        if @@pick_array.include?(@input) == true  
                #puts "This is the total guess array #{@@guess_array}."
                puts "#{@input.upcase} is in the word!"
                puts "Your guesses so far are #{@@guess_array.join(" - ").upcase}."
        end
                    
    
        #p @@board_array
        puts @@board_array.join(' ')
    end

    # if the player's guess doesn't match, add that letter to the @@wrong_guess_array
    def no_match()
        if @@pick_array.include?(@input) == false
            @@wrong_guess_array << @input
        
        puts "#{@input.upcase} is NOT in the word."
        #puts "This is the wrong guess array #{@@wrong_guess_array}."
        puts "Your guesses so far are #{@@guess_array.join(" - ").upcase}."
        puts "*** You have #{8-@@wrong_guess_array.length} wrong guess(es) left. ***"
        puts @@board_array.join(' ')    
        end
        
    end

    # alert the player that they have won when @@board_array equals @pick_array
    def win()
        if @@board_array == @@pick_array
            @@turn_count = 26
            puts "You have won the game!"
            puts "The word was #{@@pick_minus_newline.upcase}."
        end
    end

    # alert the player that they have lost when they have 8 incorrect guesses
    def lose()
        if @@wrong_guess_array.length == 8
            puts "You have lost the game!  The word was #{@@pick_minus_newline.upcase}.  Better luck next time."
            @@turn_count = 26
        end
    end

    # exit the game after the player has won or lost
    def end_game()
        if @@turn_count == 26
            exit
        end
    end

    # initialize game play    
    def play_game()
        #pick_word()
        until @@turn_count >= 26 do
            player_guess()
            match()
            no_match()
            win()
            lose()
            end_game()
        end
    end

    def save_game(obj)
        #yaml = YAML::dump()
        #game_file = GameFile.new("/my_game/saved.yaml")
        #game_file.write(yaml)
        #file = File.open("./hangman.yml", "w") do |f| YAML.dump(f)
        #file = File.open("./hangman.yml", "w") {|f| f.write(Game.to_yaml)}    
        pick_minus_newline = @@pick_minus_newline
        pick_array = @@pick_array
        pick_length = @@pick_length
        guess_array = @@guess_array
        wrong_guess_array = @@wrong_guess_array
        turn_count = @@turn_count
        board = @@board
        board_minus_newline = @@board_minus_newline 
        board_array = @@board_array       




        @game_details = [pick_minus_newline, pick_array, pick_length, guess_array, wrong_guess_array, turn_count, board, board_minus_newline, board_array]
        File.open("./hangman.yml", "w") do |file| file.write(@game_details.to_yaml)
        end

        puts "You're logging out of Hangman."
        #file.close
        exit
    end

    def load_game
        #game_file = GameFile.new("/my_game/saved.yaml")
        #yaml = game_file.read
        #YAML::load(yaml)
        begin
            yaml = YAML.load_file("./hangman.yml"
            )
        end
    end

        
end



game = Game.new
game.play_game()









