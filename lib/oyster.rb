class Oyster

  attr_reader :balance

  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
  	raise "Balance cannot exceed #{LIMIT}!" if balance + amount > LIMIT
  	@balance += amount
  end

end