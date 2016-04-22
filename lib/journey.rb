class Journey

  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :start_station, :end_station

  def initialize
    reset
  end

  def start_journey(station)
    @start_station = station
  end

  def end_journey(station)
    @end_station = station
  end

  def entry_station?
    !!start_station
  end

  def complete?
    !!start_station && !!end_station
  end

  def reset
    @start_station = nil
    @end_station = nil
  end

  def fare
    complete? ? zone_calculator : PENALTY
  end

    private

    def zone_calculator
      MINIMUM_FARE + (start_station.zone - end_station.zone).abs
    end

end