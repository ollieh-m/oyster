class Oyster

  attr_reader :balance

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
  	raise "Balance cannot exceed #{LIMIT}!" if balance + amount > LIMIT
  	@balance += amount
  end

  def touch_in
    raise "Balance must be at least £1" if balance < MIN_FARE
    @in_use = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end