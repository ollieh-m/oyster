class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance

  def initialize(journeylog=Journeylog.new)
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(deposit)
    fail "No more than #{MAX_LIMIT} in balance!" if limit_reached?(deposit)
    @balance += deposit
  end

  def touch_in(station)
    fail "insufficient funds! Need at least #{MIN_LIMIT}" if too_poor?
    @journeylog.begin(station,self)
  end

  def touch_out(station)
    @journeylog.finish(station,self)
  end

  def deduct(amount)
    @balance -= amount
  end

  def past_journeys
    @journeylog.journey_history.dup
  end

    private

    def limit_reached?(deposit)
      deposit + balance > MAX_LIMIT
    end

    def too_poor?
      balance < MIN_LIMIT
    end

end