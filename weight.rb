puts "Как тебя зовут?"
name = gets.chomp
puts "Какой у Вас рост?"
height = gets.chomp.to_i
weight = (height - 110)*1.15
puts "#{name}, твой идеальный вес - #{weight.round}кг" #округлил вес для удобства  
