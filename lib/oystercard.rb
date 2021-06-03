class Oystercard 
  attr_reader :balance, :entry_station

  DEFAULT = 2
  LIMIT = 90
  MINIMUM = 1

  def initialize 
    @balance = 0
  end

  def top_up(value = DEFAULT)
    @balance += value
    
    fail "The balance limit for this card is #{LIMIT}" unless balance_ok?

    @balance
  end

  def balance_ok?
    @balance <= LIMIT
  end
  
  def touch_in(station)
    @entry_station = station.name

    fail "Insufficient funds! You need a minimum of $#{MINIMUM}" unless sufficient_funds?
  end

  def sufficient_funds?
    @balance >= MINIMUM
  end

  def touch_out
    @entry_station = nil
    deduct
  end

  def in_journey?
    !!@entry_station
  end

  private 

  def deduct
    @balance -= MINIMUM
  end
end