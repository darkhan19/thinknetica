=begin
1. Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30
2. Заполнить массив числами от 10 до 100 с шагом 5
3. Заполнить массив числами фибоначчи до 100
4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

def days
year = {
    jan: 31,
    feb: 29,
    mar: 31,
    apr: 30,
    may: 31,
    jun: 30,
    jul: 31,
    aug: 31,
    sep: 30,
    oct: 31,
    nov: 30,
    dec: 31
}
months = year.select { |m,d| d == 30 }
puts months
end
#
#
#
# 2. Заполнить массив числами от 10 до 100 с шагом 5 (10,15,20,25)
def hundred
    array = []
      i = 10
      while i < 105
          array.push i
          i += 5
      end
end
#
#
#
# 3. Заполнить массив числами фибоначчи до 100
array = [0]
first = 0
second = 1
fibonacci = 0
    until fibonacci > 88 
      fibonacci = first + second
      first = second
      second = fibonacci
      array.push fibonacci
    end
    print array
#
#
#
# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
alphabet = ('a'..'z')
vowels = %w[a e i o u]
hash = {}

alphabet.each.with_index(1) do |letter, index|
  hash[letter] = index if vowels.include? letter
end

puts hash
#
#
#
# 
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
d = gets.chomp
puts "Please write month"
m = gets.chomp
puts "Please write year"
y = gets.chomp

when year(y) true do 
puts "високосный"


when year(y) false do
  puts "не високосный" 
end
