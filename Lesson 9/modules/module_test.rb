require_relative 'accessor.rb'
require_relative 'validation.rb'

class Test
  extend Accessor, StrongAttrAccessor
  include Validation
  attr_accessor_with_history :station, :wagon, :train,
  strong_attr_accessor(:number, Integer)

  def initialize
  @number = 123
  @station = "kirov"
  @wagon = 32
  @train = '2'
  end

  validate :station, :format, /[a-z]/
  validate :wagon, :type, Integer
  validate :train, :presence
end

Test.new.validate!

