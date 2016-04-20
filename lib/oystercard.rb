class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  PENALTY = 6 

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
    @touched_in = false
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    self.balance += deposit
  end

  def touch_in(station, journey = Journey.new)
    @touched_in = true
    journey.start_journey(station)
    message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
    fail message if too_poor?
    penalty if not_touched_out?
    journey_history << journey
  end

  def touch_out(station, journey = Journey.new)
    if !@touched_in
      penalty
      @journey_history << journey.end_journey(station)
    else
      @journey_history.last.end_journey(station)
    end
    deduct
    @touched_in = false
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

  def penalty
    self.balance -= (PENALTY - MIN_LIMIT)
  end
  
  def deduct
    self.balance -= MIN_LIMIT
  end
  
  def new_card?
    journey_history.empty?
  end
  
  def not_touched_out?
    return false if new_card?
    !journey_history.last.ended?
  end
  
end