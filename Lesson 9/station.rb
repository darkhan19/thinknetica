# frozen_string_literal: true
require_relative './modules/accessor.rb'
require_relative './modules/instance_counter.rb'
require_relative './modules/validation.rb'

class Station
  include InstanceCounter, Accessor, Validation
  attr_reader :name
  attr_accessor :trains

  REGEXP = /[a-z]/i.freeze
  validate :name, :format, REGEXP

  @@stations_list = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations_list << self
    register_instance
    validate!
  end

  def trains_each
    @trains.each { |train| yield(train) }
  end

  def self.all
    @@stations_list
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end
