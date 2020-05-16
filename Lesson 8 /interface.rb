# frozen_string_literal: true

def trains_list
  @trains.each_with_index { |train, index| puts "#{index}. #{train.number}" }
end

def stations_list
  @stations.each_with_index { |station, index| puts " #{index}. #{station.name}" }
end

def routes_list
  @routes.each_with_index { |route, index| puts "#{index}. #{route.name}" }
end

def wagons_list(train)
  @trains[train].wagons.each_with_index { |wagon, index| puts "#{index}. #{wagon.number}" }
end

def stations_index(route)
  @routes[route].stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
end

def trains_count
  stations = @stations.each { |station| }
  stations.each_with_index { |station, index| puts "#{index}. #{station.name} #{station.trains.size}" }
end

def menu0
  loop do
    puts "Выбирай что хочешь сделать?
  1. Создать станцию
  2. Создать поезд
  3. Создать маршрут и управлять станциями в маршруте
  4. Назначить маршруту поезду
  5. Добавить вагоны к поезду
  6. Отцепить вагон
  7. Перемещать поезду по маршруту
  8. Занять места в вагоне
  9. Список вагонов у поезда
  10. Показать список станций и список поездов на станции"
    choice = gets.chomp.downcase
    break if choice == 'stop'

    case choice

    when '1'
      menu1

    when '2'
      menu2

    when '3'
      menu3

    when '4'
      menu4

    when '5'
      menu5

    when '6'
      menu6

    when '7'
      menu7

    when '8'
      menu8

    when '9'
      menu9

    when '10'
      menu10

    else
      puts 'Я вас не понял'
    end
  end
end

def menu1
  puts 'Напиши название станции. Только латинские буквы'
  name = gets.chomp.downcase
  @stations << Station.new(name)
  puts 'Cтанция успешна создана'
rescue RuntimeError => e
  puts e.message
  retry
end

def menu2
  puts "Категория: Создать поезд.
  Какой поезд ты хочешь создать?
  1. пассажирский
  2. грузовой
  3. вернуться в главное меню"
  train = gets.chomp
  case train

  when '1'
    menu2_1

  when '2'
    menu2_2

  when '3'
    menu0
  end
end

def menu2_1
  puts 'Напиши номер поезда'
  number = gets.chomp
  @trains << PassangerTrain.new(number)
  puts "Поезд c номером #{number} успешно создан"
rescue RuntimeError => e
  puts e.message
  retry
end

def menu2_2
  puts 'Напиши номер поезда'
  number = gets.chomp
  @trains << CargoTrain.new(number)
  puts "Поезд c номером #{number} успешно создан"
rescue RuntimeError => e
  puts e.message
  retry
end

def menu3
  puts 'Категория: Создать маршрут и управлять станциями в маршруте.
  Что хочешь?
  1. Создать маршрут
  2. Добавить промежуточную станцию
  3. Удалить станцию из маршрута
  4. Вернуться в главное меню'

  route = gets.chomp
  case route
  when '1'
    menu3_1
  when '2'
    menu3_2
  when '3'
    menu3_3
  when '4'
    menu0
  end
end

def menu3_1
  puts 'Выбери начальную станцию. Напиши номер'
  stations_list
  from = gets.chomp.to_i
  puts 'Выбери конечную станцию. Напиши номер'
  to = gets.chomp.to_i
  puts 'Придумай название. Только латинские буквы'
  name = gets.chomp
  @routes << Route.new(@stations[from], @stations[to], name)
  puts "Маршрут #{name} успешно создан"
rescue RuntimeError => e
  puts e.message.to_s
  retry
end

def menu3_2
  if @stations.empty?
    puts 'Нужно как минимум 1 станция чтобы добавить промежуточную'
  else
    begin
    puts 'Выбери маршрут. Напиши число'
    routes_list
    route = gets.chomp.to_i
    puts 'Теперь выбери станцию. Напиши число'
    stations_list
    station = gets.chomp.to_i
    @routes[route].add_midway(@stations[station])
    puts "Cтанция #{@stations[station].name} успешно добавлена в маршрут #{@routes[route].name}"
    rescue StandardError => e
      puts e.message
      retry
  end
  end
end

def menu3_3
  if @routes.empty?
    puts 'Маршрутов нет'
  else
    puts 'Выбери маршрут откуда хочешь удалить станцию? Напиши число'
    routes_list
    route = gets.chomp.to_i
    begin
      puts 'Теперь выбери станцию которую хочешь удалить. Напиши число'
      stations_index(route)
      station = gets.chomp.to_i
      @routes[route].del_station(station)
      puts "Станция #{@routes[route].stations[station].name} успешна удалена из маршрута #{@routes[route].name}"
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end
end

def menu4
  if @trains.empty? || @routes.empty?
    puts 'Нужно сначала создать поезд/маршрут'
  else
    puts 'Выбери поезд для назначения маршрута. Напиши число'
    trains_list
    train = gets.chomp.to_i
    puts 'Теперь выбери маршрут который хочешь назначить. Напиши число'
    routes_list
    route = gets.chomp.to_i
    @trains[train].set_route(@routes[route])
    puts "Маршрут #{@routes[route].name} успешно присвоен к поезду №#{@trains[train].number} "
  end
end

def menu5
  if @trains.empty?
    puts 'Нужно сначала создать поезд'
  else
    puts 'К какому поезды ты хочешь добавить вагонов?'
    trains_list
    train = gets.chomp.to_i
    if @trains[train].cargo?
      puts 'Нужен грузовой вагон, какой объем?'
      size = gets.chomp.to_i
      @trains[train].add_wagon(CargoWagon.new(size))
    else
      puts 'Нужен пассажирский вагон, сколько сидящих мест?'
      seats = gets.chomp.to_i
      @trains[train].add_wagon(PassangerWagon.new(seats))
    end
  end
end

def menu6
  if @trains.empty?
    puts 'Поездов нет'
  else
    begin
    puts 'Выбери поезд у кого хочешь отцепить вагоны'
    trains_list
    train = gets.chomp.to_i
    puts 'Выбери вагон который хочешь отцепить'
    wagons_list(train)
    wg = gets.chomp.to_i
    @trains[train].del_wagon(wg)
    puts "У поезда №#{@trains[train].number} вагоны отцеплен"
    rescue RuntimeError => e
      puts e.message
      retry
  end
  end
end

def menu7
  puts 'Что хочешь сделать?
  1. На следующую станцию
  2. На предыдущую станцию'
  mover = gets.chomp

  case mover
  when '1'
    menu7_1

  when '2'
    menu7_2
  end
end

def menu7_1
  puts 'выбери поезд'
  trains_list
  train = gets.chomp.to_i
  if @trains[train].last_station?
    puts 'вы на конечной станции'
  else
    @trains[train].next_station
    puts "Поезд №#{@trains[train].number} на станции #{@trains[train].current_station.name}"
  end
end

def menu7_2
  puts 'выбери поезд'
  trains_list
  train = gets.chomp.to_i
  if @trains[train].frist_station?
    puts 'вы на начальной станции'
  else
    @trains[train].previus_station
    puts "Поезд №#{@trains[train].number} на станции #{@trains[train].current_station.name}"
  end
end

def menu8
  puts 'выбери поезд у которого хочешь занять места в вагоне'
  trains_list
  train = gets.chomp.to_i
  if @trains[train].cargo?
    begin
    puts 'это грузовой поезд, теперь выбери у него вагон который хочешь использовать?'
    wagons_list(train)
    wg = gets.chomp.to_i
    puts 'какой объем занять?'
    size = gets.chomp.to_i
    @trains[train].wagons[wg].add_size(size)
    rescue StandardError => e
      puts e.message
      retry
  end
  else
    begin
    puts 'это пассажирский поезд, теперь выбери у него вагон который хочешь использовать?'
    wagons_list(train)
    wg = gets.chomp.to_i
    @trains[train].wagons[wg].add_size
    puts 'Успешно сел 1 человек.'
    rescue StandardError => e
      puts e.message
      menu0
  end
  end
end

def menu9
  @stations.each do |station|
    puts "Поезда на станции #{station.name}:"
    station.trains_each do |train|
      puts "Поезд номер #{train.number}, тип: #{train.type},  кол-во вагонов: #{train.wagons.size}"
      train.wagons_each do |wagon|
        if wagon.is_a? PassangerWagon
          puts "Вагоны: №#{wagon.number}, тип: #{wagon.type}, кол-во свободных мест: #{wagon.free_space}, кол-во занятых мест #{wagon.used}"
        else
          puts "Вагоны: №#{wagon.number}, тип: #{wagon.type}, кол-во свободного места: #{wagon.free_space}, кол-во занятых мест #{wagon.used}"
        end
      end
    end
  end
end

def menu10
  puts 'Cписок станций:'
  stations_list
  puts 'Cписок поездов на станции'
  trains_count
end
