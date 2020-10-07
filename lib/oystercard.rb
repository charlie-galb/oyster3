class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise 'You cannot have more than £90 in your balance' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "balance is not enough" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct
    @entry_station = nil
  end
  
  private

  def deduct(deducted_am = MINIMUM_CHARGE)
    @balance -= deducted_am
  end


end
