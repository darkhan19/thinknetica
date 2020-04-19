def leap(year)
    if year % 4 == 0 && year % 100 != 0  
      true
   elsif year % 400 == 0 
      true
   elsif year % 4 == 0 && year % 100 == 0 && year % 400 != 0 
      false
   elsif year % 4 != 0 
      false
    end
end  

puts "Please write day"
d = gets.chomp.to_i
puts "Please write month"
m = gets.chomp.to_i
puts "Please write year"
y = gets.chomp.to_i

if leap(y) == true
    days = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    puts "Порядковый номер даты: #{days.take(m - 1).sum + d}"
else 
    days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    puts "Порядковый номер даты: #{days.take(m - 1).sum + d}"
end
