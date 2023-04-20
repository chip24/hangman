# A Hangman game made with classes in the Ruby language
require "yaml"



class Game
    # open the dictionary and chose a random word between 5 and 12 characters
    attr_reader :pick_minus_newline, :pick_array, :pick_length, :guess_array, :wrong_guess_array, :turn_count, :board, :board_minus_newline, :board_array

    @@guess_array = []
    @@wrong_guess_array = []
    @@turn_count = 0
    
    # open the dictionary file and choose a word 
    def get_word()
        f = File.open("google-10000-english-no-swears.txt")
        pick = f.select {|w| w.size > 4 && w.size <13}.sample
        puts pick
        @@pick_minus_newline = pick.strip()
        @@pick_array = @@pick_minus_newline.split(//)
        @@pick_length = @@pick_minus_newline.length
        puts @@pick_length
        f.close
    end
   # display the board as a series of underscores and tell the number of letters in the word  
    def display_board()

        puts "Your word has #{@@pick_length} letters."
        # show underscores and blanks to represent the letters in the word
        @@board = "_ " * @@pick_length
        puts @@board

        @@board_minus_newline = @@board.strip()

        @@board_array = @@board_minus_newline.split(" ")

    end

    # ask the player to guess a single letter
    def player_guess()
        puts "\nChoose a letter from A to Z or type SAVE to save your game."
        @input = gets.chomp 
        if @input == "SAVE"
            save_game()
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
                
                puts "#{@input.upcase} is in the word!"
                puts "Your guesses so far are #{@@guess_array.join(" - ").upcase}."
        end
                    
    
        # show the board with the correct guesses in it
        puts @@board_array.join(' ')
    end

    # if the player's guess doesn't match, add that letter to the @@wrong_guess_array
    def no_match()
        p @@pick_array
        p @input
        if @@pick_array.include?(@input) == false
            puts @@pick_array.include?(@input)
            @@wrong_guess_array << @input
        
            puts "#{@input.upcase} is NOT in the word."
        end
            
            puts "Your guesses so far are #{@@guess_array.join(" - ").upcase}."
            puts "*** You have #{8-@@wrong_guess_array.length} wrong guess(es) left. ***"
            puts @@board_array.join(' ')    
        
        
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

    # initialize game play for a new game   
    def play_game()
        get_word()
        display_board()
        until @@turn_count >= 26 do
            player_guess()
            match()
            no_match()
            win()
            lose()
            end_game()
        end
    end
    # initialize game play for a loaded game
    def play_loaded_game()
        load_game()
        puts "Welcome back to your saved game."
        puts "Your board is below."
        puts @@board_array.join(' ')
        puts "Below are your guesses so far."
        puts @@guess_array.join(" - ").upcase
        puts @@wrong_guess_array.length
        puts @@turn_count
        p @@wrong_guess_array
        puts "You have #{8 - @@wrong_guess_array.length} wrong guesses left."
        #display_board()
        until @@turn_count >= 26 do
            player_guess()
            match()
            no_match()
            win()
            lose()
            end_game()
        end
    end
        
# save game information to a ymml file and exit the game
    def save_game()
        
        @game_details = {"pick_minus_newline" => @@pick_minus_newline, "pick_array" => @@pick_array, "pick_length" => @@pick_length, "guess_array" => @@guess_array, "wrong_guess_array" => @@wrong_guess_array, "turn_count" => @@turn_count, "board" => @@board, "board_minus_newline" => @@board_minus_newline, "board_array" => @@board_array}

        file = File.open("./hangman.yml", "w") do |f| YAML.dump(@game_details, f)
        end
        

        puts "You're logging out of Hangman."
        file.close
        exit
    end
# load the information of a saved game stored in a yml file 
    def load_game()
        
        loaded_game = open("./hangman.yml") {|f| YAML.load(f)}
    
        p loaded_game
        p loaded_game.class
        #p loaded_game['pick_minus_newline']
        @@pick_minus_newline = loaded_game["pick_minus_newline"]
        p @@pick_minus_newline
        p @@pick_array = loaded_game["pick_array"]
        p @@pick_length = loaded_game["pick_length"]
        p @@guess_array = loaded_game["guess_array"]
        p @@wrong_guess_array = loaded_game["wrong_guess_array"] 
        p @@turn_count = loaded_game["turn_count"] 
        p @@board = loaded_game["board"]
        p @@board_minus_newline = loaded_game["board_minus_newline"] 
        p @@board_array = loaded_game["board_array"]

    end

end

# welcome player to game and have them choose to begin a new game or resume a saved game
puts "Welcome to HANGMAN! Enter 1 to start a new game or 2 to load a saved game."
new_or_saved = gets.chomp
    until new_or_saved == "1" || new_or_saved == "2"
        puts "You have entered an incorrect choice."
        puts "Enter either 1 or 2."
        new_or_saved = gets.chomp
    end

        if new_or_saved == "1"
            game = Game.new
            game.play_game()

        elsif new_or_saved == "2"
            game = Game.new
            game.play_loaded_game()
            
        

        end













