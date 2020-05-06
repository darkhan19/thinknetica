class Station
  include InstanceCounter
  attr_reader :name
  attr_accessor :trains

  @@list = []
  def initialize(name)
    @name = name
    @trains = []
    @@list << self    
  end

  def self.all
    @@list
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end 
