class Oystercard

  MAX_LIMIT = 90

  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    self.balance += deposit
  end

  def deduct(spending)
    self.balance -= spending
  end

  private

  def limit_reached?(deposit)
    deposit + balance > Oystercard::MAX_LIMIT
  end

end