class Journey
    
  PENALTY = 6
  STANDARD_FARE = 1
  
  attr_reader :end_station, :start_station
  
  def initialize
    reset
  end
 
  def end_journey(station,card)
    @end_station = station
    card.deduct(fare)
    card.add_to_log(start_station,end_station)
    reset
  end
  
  def start_journey(station,card)
    unless @start_station.nil?
      card.deduct(fare)
      card.add_to_log(@start_station,nil)
    end
    @start_station = station
  end
  
  def fare
    if @start_station.nil? or @end_station.nil?
      PENALTY
    else
      STANDARD_FARE
    end
  end

  private

  def reset
    @start_station = nil
    @end_station = nil
  end
  
end