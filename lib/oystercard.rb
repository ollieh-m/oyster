
class Oystercard

	attr_reader :balance

	MAXIMUM_BALANCE = 90

	def initialize
		@balance = 0
	end

	def top_up(amount)
    	fail "Maximum balance #{MAXIMUM_BALANCE}exceeded" if amount + balance > MAXIMUM_BALANCE
    	@balance += amount
  	end

  	def deduct(amount)
  		@balance -= amount
  	end

  	def touch_in
  		@in_use = true
  	end

  	def touch_out
  		@in_use = false
  	end

  	def in_journey?
  		@in_use
  	end
end