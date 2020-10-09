class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journeys_history, :journey, :in_journey

  def initialize
    @balance = 0
    @journey = {}
    @journeys_history = []
    
  end

  def top_up(amount)
    raise 'You cannot have more than £90 in your balance' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "balance is not enough" if @balance < MINIMUM_BALANCE
    @journey_obj = Journey.new(station)
    @journey[:entry_station] = station
  end

  def touch_out(station)
    deduct
    @journey[:exit_station] = station
    add_journey_to_hist
  end

  def add_journey_to_hist
    @journeys_history << @journey
  end

  private

  def deduct(deducted_am = MINIMUM_CHARGE)
    @balance -= deducted_am
  end
end
