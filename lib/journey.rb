class Journey
    
  PENALTY = 6
  STANDARD_FARE = 1
  
  attr_reader :end_station, :start_station
  
  def initialize
    @start_station = nil
    @end_station = nil
  end
 
  def start_journey(station)
    @start_station = station
  end

  def end_journey(station)
    @end_station = station
  end

  def exit_nil?
    end_station.nil?
  end

  def complete?
    !!start_station && !!end_station
  end
   
  def fare
    if @start_station.nil? or @end_station.nil?
      PENALTY
    else
      STANDARD_FARE
    end
  end
  
end