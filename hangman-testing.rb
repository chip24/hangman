f = File.open("google-10000-english-no-swears.txt")
pick = f.select {|w| w.size > 4 && w.size <13}.sample
puts pick
p pick
puts pick.length
pick_minus_newline = pick.strip()
p pick_minus_newline
@pick_array = pick_minus_newline.split(//)
p @pick_array
@pick_length = pick_minus_newline.length
puts @pick_length
f.close

@guess_array = []
@wrong_guess_array = []
@turn_count = 0

puts "Your word has #{@pick_length} letters."

@board = "_ " * @pick_length
puts @board

@board_minus_newline = @board.strip()

@board_array = @board_minus_newline.split(" ")
p @board_array


def player_guess()
    puts "Choose a letter from A to Z."
    @input = gets.chomp 
        until @input.match("[a-zA-Z]") && @input.length == 1 
        puts "Make sure you have only entered a single  letter between A and Z."
        @input = gets.chomp
        end
    @guess_array << @input
    @turn_count += 1
end

def match()
    @pick_array.each_with_index do |element,idx|
        #p element, idx
        if element == @input
            puts element
            @board_array[idx] = element
        
=begin    
        elsif element != @input
            #puts "#{@input} is not in the puzzle."
            @wrong_guess_array << @input unless @wrong_guess_array.include?(@input)
=end   

            
        end

    
            #p @board_array


    end
    p @board_array
    puts @board_array.join(' ')
    puts "This is the wrong guess array #{@wrong_guess_array}." 
    puts "This is the right guess array #{@guess_array}."
end

#def print_board()
    
def play_game()

    until @turn_count >= 26 do
        player_guess()
        match()
    end
end

play_game()


