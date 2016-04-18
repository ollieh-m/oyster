class Oystercard

MAXIMUM_BALANCE = 90

  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
    @money = 0
  end

  def top_up(money)
    @money = money
    fail "cannot top up beyond £#{MAXIMUM_BALANCE} maximum" if at_maximum?
    @balance += money
  end

  def deduct(money)
    @money = money
    @balance -= money
  end

  def in_journey?
    in_use
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  private

  def at_maximum?
    (balance + @money) > MAXIMUM_BALANCE
  end

end