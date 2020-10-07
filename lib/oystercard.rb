class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(amount)
    raise 'You cannot have more than £90 in your balance' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    @journey_status
  end

  def touch_in
    raise "balance is not enough" if @balance < MINIMUM_BALANCE
    @journey_status = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @journey_status = false
  end
  
  private

  def deduct(deducted_am)
    @balance -= deducted_am
  end


end
