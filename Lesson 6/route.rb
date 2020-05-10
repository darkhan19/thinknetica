class Route
  include InstanceCounter
  attr_reader :name
  attr_accessor :stations
  
  REGEXP = /[a-z]/i 
    
  def initialize(from, to, name)
    @stations = [from, to]
    @name = name
    validate!
    register_instance
  end
    
  def add_midway(name)
    raise "Такая станция уже есть в маршруте!" if @stations.include?(name)
    @stations.insert(-2, name)    
  end

  def last?
    self.stations == stations.last 
  end

  def first?
    self.stations == stations.first
  end

  def del_route(name)
    @stations.delete(name)
  end

  def del_station(index)
    raise "Нельзя удалить начальную станцию" if self.stations[index] == self.stations.first
    raise "Нельзя удалить конечную станцию" if self.stations[index] == self.stations.last
    @routes[route].stations.delete_at(station)
  end

  protected

  def validate!
    raise "Неверный формат! Только латинские буквы!" if name !~ REGEXP
  end
end
