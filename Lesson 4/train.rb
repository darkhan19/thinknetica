class Train
  attr_reader :number, :wagons, :current_station, :current_route, :speed

  def initialize(number) 
    @number = number
    @wagons = []
    @current_route = []
    @current_station = []
  end

  def passanger?
    self.is_a? PassangerTrain
  end

  def cargo?
    self.is_a? CargoTrain
  end

def current_station
  puts @current_station
end
  def add_wagon(n)
    @wagons << n
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

  def previous_station
    if self.first_station?
      puts "вы на начальной станции"
    else 
      count = @current_route.stations.index(@current_station) - 1
      @current_station.send_train(self)
      @current_station = @current_route.stations[count]
      @current_station.add_train(self) 
    end
  end

  def show_stations
    if self.first_station?
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

  private #только внутри класса

  def first_station?
    @current_station == @current_route.stations.first
  end

  def previous_station?
    @current_station == @current_route.stations.last
  end
end
