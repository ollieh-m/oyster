class Journey
  
  attr_reader :end_station, :start_station
  
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
    !@start_station.nil?
  end

  def complete?
    !!start_station && !!end_station
  end

  def reset
    @start_station = nil
    @end_station = nil
  end
  
end