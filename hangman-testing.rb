f = File.open("google-10000-english-no-swears.txt")
pick = f.select {|w| w.size > 4 && w.size <13}.sample
puts pick
pick_length = pick.length 
puts pick_length
f.close

puts "Your word has #{pick_length} letters."
puts "_ " * pick_length

puts "Choose a letter from A to Z."
input = gets.chomp 
    until input.count("^a-zA-Z") == 0 && input.count == 1
    puts "Make sure you have only entered a single  letter between A and Z."
    input = gets.chomp
    end
