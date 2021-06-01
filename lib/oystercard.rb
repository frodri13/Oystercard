class Oystercard 
  attr_reader :balance

  DEFAULT = 5
  LIMIT = 90

  def initialize 
    @balance = 0
  end

  def top_up(value = DEFAULT)
    @balance += value
    fail "The balance limit for this card is 90" unless balance_ok
  end

  def balance_ok
    @balance <= LIMIT
  end
end