puts "Введите длину стороны A"
a = gets.chomp.to_i
puts "Введите длину стороны B"
b = gets.chomp.to_i
puts "Введите длину стороны C"
c = gets.chomp.to_i
a, b, h = [a, b, c].sort
if h**2 == (a + b)**2
    puts "Треугольник прямоугольный"
  elsif (a == h) && (a == b && h == b) 
    puts "Треугольник равнобедренный и равносторонний"
  else # a == b || (b == h || a == h)
    puts "Треугольник равнобедренный"   
end
