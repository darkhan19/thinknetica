class Train
  include Company, InstanceCounter
  attr_reader :number, :wagons, :current_station, :current_route, :speed

  REGEXP = /^[a-z]{3}[0-9]{2}$/i
  
  @@list = {}

  def initialize(number) 
    @number = number
    validate!
    @wagons = []
    @current_route = []
    @current_station = []
    @@list[number] = self
    register_instance
  end

  def self.find(number)
    @@list[number]
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
      count = @current_route.stations.index(@current_station) + 1
      @current_station.send_train(self)
      @current_station = @current_route.stations[count]
      @current_station.add_train(self)
  end  

  def previous_station
      count = @current_route.stations.index(@current_station) - 1
      @current_station.send_train(self)
      @current_station = @current_route.stations[count]
      @current_station.add_train(self) 
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def first_station?
    @current_station == @current_route.stations.first
  end

  def last_station?
    @current_station == @current_route.stations.last
  end

  protected

  def validate!
    raise "Неверный формат!" if number !~ REGEXP
  end
end
