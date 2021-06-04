require_relative 'station'

class Oystercard 
  attr_reader :balance, :entry_station, :exit_station, :journeys

  DEFAULT = 2
  LIMIT = 90
  MINIMUM = 1

  def initialize 
    @balance = 0
    @journeys = []
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
    fail "Insufficient funds! You need a minimum of $#{MINIMUM}" unless sufficient_funds?

    @entry_station = station
  end

  def sufficient_funds?
    @balance >= MINIMUM
  end

  def touch_out(station)
    @exit_station = station
    deduct
    @journeys << {entry: @entry_station, exit: @exit_station}
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private 

  def deduct
    @balance -= MINIMUM
  end
end