class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    self.balance += deposit
  end

  def touch_in
    message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
    fail message if too_poor?
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
    deduct
  end

  private

  attr_writer :balance, :in_journey

  def limit_reached?(deposit)
    deposit + balance > Oystercard::MAX_LIMIT
  end

  def too_poor?
    balance < Oystercard::MIN_LIMIT
  end

  def deduct
    self.balance -= MIN_LIMIT
  end

end