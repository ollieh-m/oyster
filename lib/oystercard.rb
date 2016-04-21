class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance, :journey_history

  def initialize(journey=Journey.new)
    @balance = 0
    @journey_history = []
    @touched_in = false
    @journey = journey
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    @balance += deposit
  end

  def touch_in(station)
    fail "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}" if too_poor?
    journey.start_journey(station,self)
  end

  def touch_out(station)
    journey.end_journey(station,self)
  end
  
  def deduct(amount)
    @balance -= amount
  end

  def add_to_log(startstation,endstation)
    journey_history << {entrystation: startstation, exitstation: endstation}
  end

  private

  attr_reader :journey

  def limit_reached?(deposit)
    deposit + balance > Oystercard::MAX_LIMIT
  end

  def too_poor?
    balance < Oystercard::MIN_LIMIT
  end  
  
end