class Oystercard 
  attr_reader :balance

  DEFAULT = 5

  def initialize 
    @balance = 0
  end

  def top_up(value = DEFAULT)
    @balance += value
  end
end