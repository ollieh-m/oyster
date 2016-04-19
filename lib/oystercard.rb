class Oystercard

  MAX_LIMIT = 90

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

  def deduct(spending)
    self.balance -= spending
  end

  def touch_in
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
  end

  private

  attr_writer :balance, :in_journey

  def limit_reached?(deposit)
    deposit + balance > Oystercard::MAX_LIMIT
  end

end