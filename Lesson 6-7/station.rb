class Station
  include InstanceCounter
  attr_reader :name
  attr_accessor :trains

  REGEXP = /[a-z]/i 

  @@list = []
 
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@list << self
    register_instance 
  end

  def trains_each
    @trains.each {|train| yield(train)}
  end 

  def self.all
    @@list
  end

  def valid?
    validate!
    true
  rescue 
    false
  end 

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  private 

  def validate!
    raise "Только латинские буквы!" if name !~ REGEXP
  end
end 
