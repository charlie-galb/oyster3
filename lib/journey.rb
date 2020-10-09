require 'oystercard.rb'

class Journey
    
    attr_reader :entry_station, :exit_station
    
    PENALTY_FARE = 10

    def initialize (entry_station)
        @entry_station = entry_station
        @exit_station = nil
        @complete = false
        @in_journey = false
    end

    def in_journey?
        @in_journey
    end

    def entry(entry_station)
        @entry_station = entry_station
        @in_journey = true
    end

    def exit(exit_station)
        @exit_station = exit_station
        @in_journey = false
        fare
    end

    def fare
        Oystercard::MINIMUM_CHARGE
    end

    def complete?
        @complete = true
    end


end