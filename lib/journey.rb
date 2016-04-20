class Journey
    
  attr_reader :end_station, :start_station
  
  def initialize(start_station)
      @start_station = start_station
      @end_station = nil
  end
 
  def end_journey(station)
    @end_station = station
  end
  
  def ended?
    !!end_station
  end
  
end