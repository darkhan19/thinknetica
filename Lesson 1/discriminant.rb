puts "Введите коефициент a"
a = gets.chomp.to_i
puts "Введите коефициент b"
b = gets.chomp.to_i
puts "Введите коефициент c"
c = gets.chomp.to_i
d = (b**2) - (4 * a * c)
b = -1 * b

if d < 0 
  puts "Корней нет"
elsif d > 0  
  sqrtd =  Math.sqrt(d) 
  x1 = (b + sqrtd) / (2 * a)
  x2 = (b - sqrtd) / (2 * a)
  print "2 корня, x1 = #{x1}, x2 = #{x2}"
else #d == 0 
  x1 = b / (2 * a)
  print "1 корень = #{x1}"
end
