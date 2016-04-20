class Journey
    
  PENALTY = 6
  STANDARD_FARE = 1
  
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
  
  def completed?
    !!end_station
  end
  

  def fare(card)
    if @start_station.nil? or @end_station.nil?
      card.deduct(PENALTY)
    else
      card.deduct(STANDARD_FARE)
    end
  end
  
end