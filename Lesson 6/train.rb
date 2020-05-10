class Train
  include Company, InstanceCounter
  attr_reader :number, :wagons, :current_station, :current_route, :speed

  REGEXP = /^[a-z]{3}[0-9]{2}$/i
  
  @@list = []
  def initialize(number) 
    @number = number
    validate!
    @wagons = []
    @current_route = []
    @current_station = []
    @@list << self
    register_instance
  end

  def self.find(n)
    @@list.find { |x| x.number == n}
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
    if self.last_station?
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

    elsif self.last_station?
      count = @current_route.stations.index(@current_station) - 1
      puts "Вы на конечной станции #{@current_station.name}, предыдущая станция #{@current_route.stations[count].name}"
    else
      forward = @current_route.stations.index(@current_station) + 1
      backward = @current_route.stations.index(@current_station) - 1
      puts "Вы на станции #{@current_station.name}, предыдущая станция #{@current_route.stations[backward].name}, следующая станция #{@current_route.stations[forward].name}"    
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Неверный формат!" if number !~ REGEXP
  end
    

  private 

  def first_station?
    @current_station == @current_route.stations.first
  end

  def last_station?
    @current_station == @current_route.stations.last
  end
end
