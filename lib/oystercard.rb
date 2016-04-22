class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  attr_reader :balance

  def initialize(journeylog=Journeylog.new)
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(deposit)
    message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
    fail message if limit_reached?(deposit)
    @balance += deposit
  end

  def touch_in(station)
    fail "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}" if too_poor?
    @journeylog.begin(station,self)
  end

  def touch_out(station)
    @journeylog.finish(station,self)
  end

  def deduct(amount)
    @balance -= amount
  end

  def past_journeys
    @journeylog.journey_history
  end

    private

    def limit_reached?(deposit)
      deposit + balance > Oystercard::MAX_LIMIT
    end

    def too_poor?
      balance < Oystercard::MIN_LIMIT
    end

end