class Oyster

  attr_reader :balance

  LIMIT = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
  	raise "Balance cannot exceed #{LIMIT}!" if balance + amount > LIMIT
  	@balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Balance must be at least £1" if balance < MIN_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end