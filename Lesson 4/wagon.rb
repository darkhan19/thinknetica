class Wagon
  attr_accessor :wagon
  def initialize(count)
    @count = count
  end 

  def minus(n)
    self.count -= n
  end

  def cargo?
    self.class == CargoWagon 
  end

  def passanger?
    self.class == PassangerWagon 
  end
end

