class Route
  include InstanceCounter
  attr_reader :stations, :name
    
  def initialize(from, to, name)
    @stations = [from, to]
    @name = name
  end
    
  def add_midway(name)
    @stations.insert(-2, name)    
  end

  def last?
    self.stations == stations.last 
  end

  def first?
    self.stations == stations.first?
  end

  def del_route(name)
    @stations.delete(name)
  end
end
