# frozen_string_literal: true

class Station
  include InstanceCounter
  attr_reader :name
  attr_accessor :trains

  REGEXP = /[a-z]/i.freeze

  @@stations_list = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations_list << self
    register_instance
  end

  def trains_each
    @trains.each { |train| yield(train) }
  end

  def self.all
    @@stations_list
  end

  def valid?
    validate!
    true
  rescue StandardError
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
    raise 'Только латинские буквы!' if name !~ REGEXP
  end
end
