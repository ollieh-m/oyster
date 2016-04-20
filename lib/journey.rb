class Journey
    
  attr_reader :end_station, :start_station
  
  def initialize
      @start_station = nil
      @end_station = nil
  end
 
  def end_journey(station)
    @end_station = station
    self
  end
  
  def start_journey(station)
    @start_station = station
  end
  
  def ended?
    !!end_station
  end
  
end