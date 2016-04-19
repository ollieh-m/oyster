class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    self.balance += deposit
  end

  def touch_in(station)
    message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
    fail message if too_poor?
    self.in_journey = true
    self.entry_station = station
  end

  def touch_out
    self.in_journey = false
    deduct
    self.entry_station = nil
  end

  def in_journey?
    !entry_station.nil?
  end

  private

  attr_writer :balance, :entry_station

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