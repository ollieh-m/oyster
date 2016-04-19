
class Oystercard

	attr_reader :balance, :entry_station

	MAXIMUM_BALANCE = 90

  MINIMUM_FARE = 1

	def initialize
		@balance = 0
	end

	def top_up(amount)
    fail "Maximum balance #{MAXIMUM_BALANCE}exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "balance must be at least £#{MINIMUM_FARE}" if balance < MINIMUM_FARE
  	@in_use = true
    @entry_station = station
  end

  def touch_out
  	@in_use = false
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
  	not @entry_station.nil? #!!entry_station
  end

    private

    def deduct(amount)
      @balance -= amount
    end

end