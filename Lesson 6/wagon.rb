class Wagon
  include Company, InstanceCounter
  attr_accessor :wagon

  def initialize(count)
    @count = count
  end 

  def minus(n)
    raise "Нельзя отцепить вагонов больше чем имеется" if self.count < n
    self.count -= n
  end

  def cargo?
    self.class == CargoWagon 
  end

  def passanger?
    self.class == PassangerWagon 
  end
end

