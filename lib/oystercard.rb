class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :journeys_history, :exit_station

  def initialize
    @balance = 0
    @journey = {}
    @journeys_history = []
    
  end

  def top_up(amount)
    raise 'You cannot have more than £90 in your balance' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    !!true
  end

  def touch_in(station)
    raise "balance is not enough" if @balance < MINIMUM_BALANCE
    @journey[:entry_station] = station
    in_journey?
  end

  def touch_out(station)
    deduct
    @journey[:exit_station] = station
    add_journey_to_hist
    in_journey?
  end

  def add_journey_to_hist
    @journey = {entry_station: @entry_station, exit_station: @exit_station}
    @journeys_history << @journey
  end

  private

  def deduct(deducted_am = MINIMUM_CHARGE)
    @balance -= deducted_am
  end
end
