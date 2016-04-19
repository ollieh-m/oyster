class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    self.balance += deposit
  end

  def touch_in(station)
    message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
    fail message if too_poor?
    self.entry_station = station
    record_entry(station)
  end

  def touch_out(station)
    deduct
    self.entry_station = nil
    record_exit(station)
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
  
  def record_entry(station)
    @journey_history << {start_station: station}
  end
  
  def record_exit(station)
    @journey_history.last[:exit_station] = station 
  end

end