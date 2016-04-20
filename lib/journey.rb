class Journey
    
  PENALTY = 6
  STANDARD_FARE = 1
  
  attr_reader :end_station, :start_station
  
  def initialize
    @start_station = nil
    @end_station = nil
  end
 
  def end_journey(station,card)
    @end_station = station
    card.deduct(STANDARD_FARE) unless @start_station.nil?
    self
  end
  
  def start_journey(station)
    @start_station = station
  end
  
  def completed?
    !!end_station
  end
  
  def levy_penalty(card)
    card.deduct(PENALTY)
  end
  
end