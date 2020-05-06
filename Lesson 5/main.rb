require_relative 'modules.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passanger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passanger_wagon.rb'
require_relative 'cargo_wagon.rb'
 
@stations = [] 
@trains = []
@wagons = []
@routes = []

def digit?(number) 
  number =~ /[0-9]/ 
end 
  
def letter?(name)
  name =~ /[A-Za-z]/
end 

def trains_list
  @trains.each_with_index { |x, index| puts "#{index}. #{x.number}"}
end

loop do
  
puts "Выбирай что хочешь сделать?
1. Создать станцию
2. Создать поезд
3. Создать маршрут и управлять станциями в маршруте
4. Назначить маршруту поезду
5. Добавить вагоны к поезду
6. Отцепить вагон
7. Перемещать поезду по маршруту
8. Показать список станций и список поездов на станции"
choice = gets.chomp.downcase
break if choice  == 'stop'

case choice 
  
when '1' 
 puts "Напиши название станции"
 name = gets.chomp.downcase
 if letter?(name)
  @stations << Station.new(name)
  puts "станция успешна создана"
 else 
  puts "только латинские бувы" 
 end

when '2'
  puts "Какой поезд ты хочешь создать?
  1. пассажирский
  2. грузовой"
  train = gets.chomp
  case train

  when '1'
    puts 'Напиши номер поезда'
    number = gets.chomp
    if digit?(number) 
      @trains << PassangerTrain.new(number)
      puts "Поезд успешно создан"
     else 
      puts "только цифры" 
    end

  when '2'
    puts 'Напиши номер поезда'
    number = gets.chomp
    if digit?(number)
      @trains << CargoTrain.new(number)
      puts "Поезд успешно создан"
     else 
      puts "только цифры" 
    end
  end

when '3'
  puts "Что хочешь? 
  1. Создать маршрут
  2. Добавить промежуточную станцию
  3. Удалить станцию из маршрута"
  route = gets.chomp
  case route
  when '1' 
    if @stations.length < 2
      puts "Нужно как минимум 2 станции чтоб создать маршрут"
    else 
      puts "выбери начальную станцию. Напиши номер"  
      @stations.each_with_index { |x, index| puts " #{index}. #{x.name}" }
      from = gets.chomp.to_i
      puts "выбери конечную станцию. Напиши номер"
      to = gets.chomp.to_i
      puts "Придумай название"
      name = gets.chomp
      @routes << Route.new(@stations[from],@stations[to], name)
      puts "Маршрут успешно создан"
    end

  when '2'
    if @stations.length == 0
      puts "Нужно как минимум 1 станции чтобы добавить промежуточную"
    else 
      puts "Выбери маршрут. Напиши число" 
      @routes.each_with_index { |x, index| puts "#{index}. #{x.name}" }
      rt = gets.chomp.to_i
      puts "Теперь выбери станцию. Напиши число"
      @stations.each_with_index { |x, index| puts "#{index}. #{x.name}" }
      st = gets.chomp.to_i 
      @routes[rt].stations.insert(-2, @stations[st])
      puts "Станция успешно добавлена"
    end
  
    
  when '3'
    if @routes.empty?
      puts "Маршрутов нет"
    else
      puts 'Выбери маршрут откуда хочешь удалить станцию? Напиши число'
      @routes.each_with_index { |x, index| puts "#{index}. #{x.name}" }
      rt = gets.chomp.to_i
      puts 'Теперь выбери станцию которую хочешь удалить. Напиши число'
      @routes[rt].stations.each_with_index { |x, index| puts "#{index}. #{x.name}" }
      st = gets.chomp.to_i
      if @routes[rt].stations[st] == @routes[rt].stations.first || @routes[rt].stations[st] == @routes[rt].stations.last  #хотел бы засунуть в какой нибудь метод типа .last? не смог придумать
        puts "Начальную и конечную станцию удалить нельзя"
      else 
        @stations << routes[rt].stations[st]
        puts "Станция #{@routes[rt].stations[st].name} успешна удалена из маршрута"
        @routes[rt].stations.delete_at(st)
      end
    end
  end

when '4'
  if @trains.empty? || @routes.empty?
    puts "Нужно сначала создать поезд/маршрут"
  else
    puts 'Выбери поезд для назначения маршрута. напиши число'
    trains_list
    tr = gets.chomp.to_i
    puts 'Теперь выбери маршрут который хочешь назначить. напиши число'
    @routes.each_with_index { |x, index| puts "#{index}. #{x.name}" }
    rt = gets.chomp.to_i
    @trains[tr].set_route(@routes[rt])
    puts "Маршрут успешно присвоен"
  end

when '5'
  if @trains.empty? 
    puts "Нужно сначала создать поезд"
  else 
    puts 'к какому поезды ты хочешь добавить вагонов?'
    trains_list 
    tr = gets.chomp.to_i
    puts 'сколько вагонов хочешь добавить к поезду?'
    count = gets.chomp.to_i
    if @trains[tr].cargo?
      @trains[tr].add_wagon(CargoWagon.new(count))
    else 
      @trains[tr].add_wagon(PassangerWagon.new(count))
    end
  end

when '6'
  puts 'выбери поезд у кого хочешь отцепить вагоны'
  trains_list 
  tr = gets.chomp.to_i
  puts 'сколько вагонов хочешь отцепить'
  count = gets.chomp.to_i
  @trains[tr].wagons[0].minus(count)
  puts 'вагоны успешно отцеплены'

when '7'       
  puts 'Что хочешь сделать?
  1. На следующую станцию
  2. На предыдущую станцию'
  mover = gets.chomp
    
    case mover
    when "1"
      puts "выбери поезд"
      trains_list
      tr = gets.chomp.to_i
      @trains[tr].next_station

    when "2"
      puts "выбери поезд"
      trains_list
      tr = gets.chomp.to_i
      @trains[tr].previous_station
    end

when '8'
  puts "список станций:"
  @stations.each_with_index { |x, index| puts "#{index}. #{x.name}"}
  puts "список поездов на станции"
  st = @stations.each {|x| x}
  st.each_with_index { |x, index| puts "#{index}. #{x.name} #{x.trains.size}"}

else 
 puts "Я вас не понял"
end
end







