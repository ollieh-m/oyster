class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    @balance += deposit
  end

  def touch_in(station,journey=Journey.new)
    check_journey
    start(journey,station)
    add_to_log
  end

  def touch_out(station,journey_reset=Journey.new)
    if @journey_history.empty? or @journey_history.last.complete?
      @journey = journey_reset
      add_to_log
    end
    journey.end_journey(station)
    deduct(journey.fare)
  end
  
    private

    attr_reader :journey
    
    def start(journey,station)
      @journey = journey
      journey.start_journey(station)
    end

    def check_journey
      fail "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}" if too_poor?
      unless @journey_history.empty?
        deduct(@journey_history.last.fare) if @journey_history.last.exit_nil?
      end
    end

    def deduct(amount)
      @balance -= amount
    end

    def add_to_log
      @journey_history << journey
    end
    
    def limit_reached?(deposit)
      deposit + balance > Oystercard::MAX_LIMIT
    end

    def too_poor?
      balance < Oystercard::MIN_LIMIT
    end  
  
end