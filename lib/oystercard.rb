class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  PENALTY = 6 

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
    @touched_in = false
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    self.balance += deposit
  end

  def touch_in(station, journey = Journey.new)
    journey.start_journey(station)
    fail "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}" if too_poor?
    journey.levy_penalty(self) if @touched_in
    journey_history << journey
    @touched_in = true
  end

  def touch_out(station, journey = Journey.new)
    if !@touched_in
      journey.levy_penalty(self)
      @journey_history << journey.end_journey(station)
    else
      @journey_history.last.end_journey(station)
    end
    deduct
    @touched_in = false
  end

  private

  attr_writer :balance

  def limit_reached?(deposit)
    deposit + balance > Oystercard::MAX_LIMIT
  end

  def too_poor?
    balance < Oystercard::MIN_LIMIT
  end

  def penalty
    self.balance -= PENALTY
  end
  
  def deduct
    !@touched_in ? penalty : self.balance -= MIN_LIMIT
  end
  
end