class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []    
  end

  def add_train(train)
    @trains << train
  end

  def train_list
    puts @trains
  end

  def send_train(train)
    @trains.delete(train)
  end
  
  def train_type
    passanger = @trains.select { |train| train.type == "пассажирский"}.size
    cargo = @trains.select { |train| train.type == "грузовой"}.size
    puts "Пассажирских поездов: #{passanger}"
    puts "Грузовых поездов: #{cargo}"
  end
end



class Route
  attr_reader :stations
    
  def initialize(from, to)
    @stations = [from, to]
  end
    
  def add_midway(name)
    @stations.insert(-2, name)    
  end

  def del_route(name)
    @stations.delete(name)
  end

  def show_route
    @stations.each { |station| puts station.name }    
  end
end

class Train
  attr_reader  :type, :number, :railcars, :current_station, :current_route, :speed
  
  def initialize(number, type, railcars) 
    @number = number
    @type = type
    @railcars = railcars
    @speed = 0
    @current_route = []
    @current_station = []
  end

  def speed_up(number)
    @speed += number 
  end

  def stop
    @speed = 0
  end

  def current_speed
    puts "your speed is #{@speed} kmh"
  end

  def railcars_info
    puts "total railcars is #{@railcars}"
  end

  def unhook_railcars(number)
    if @speed > 0
      puts "U can't do that while moving"
    elsif @railcars == 0 
      puts "no railcars"
    elsif @railcars < number 
      puts "u cant do that"
    else 
      @railcars -= number
    end
  end
  
  def set_route(route)
    @current_route = route
    @current_station = route.stations[0]
    @current_station.add_train(self)
  end

  def next_station
    if @current_station == @current_route.stations.last
      puts "вы на конечной станции"
    else 
      count = @current_route.stations.index(@current_station) + 1
      @current_station.send_train(self)
      @current_station = @current_route.stations[count]
      @current_station.add_train(self)
    end
  end  

  def frist_station?
    @current_station == @current_route.stations.first
  end

  def previous_station?
    @current_station == @current_route.stations.last
  end


  def previous_station
    if self.frist_station?
      puts "вы на начальной станции"
    else 
      count = @current_route.stations.index(@current_station) - 1
      @current_station.send_train(self)
      @current_station = @current_route.stations[count]
      @current_station.add_train(self) 
    end
  end

  def show_stations
    if self.frist_station?
      puts "Вы на начальной станции #{@current_station.name}, следующая станция #{@current_route.stations[1].name}"

    elsif @current_station == @current_route.stations.last
      count = @current_route.stations.index(@current_station) - 1
      puts "Вы на конечной станции #{@current_station.name}, предыдущая станция #{@current_route.stations[count].name}"
    else
      forward = @current_route.stations.index(@current_station) + 1
      backward = @current_route.stations.index(@current_station) - 1
      puts "Вы на станции #{@current_station.name}, предыдущая станция #{@current_route.stations[backward].name}, следующая станция #{@current_route.stations[forward].name}"    
    end
  end
end

=begin
almaty = Station.new("almaty")
kirov = Station.new("kirov")
taldyk = Station.new("taldyk")
zubr = Station.new("zubr")

doroga = Route.new(almaty, kirov)
doroga.add_midway(taldyk)
doroga.add_midway(zubr)

poezd2 = Train.new(7778, "пассажирский", 20)
poezd = Train.new(777, "пассажирский", 20)

poezd.set_route(doroga)
poezd.next_station
poezd.next_station
zubr.train_type
taldyk.train_type

poezd.show_stations

zubr.train_list
kirov.train_list
=end
