require 'oystercard.rb'

class Journey

    attr_reader :entry_station, :exit_station, :journey

    PENALTY_FARE = 10

    def initialize (entry_station)
        @entry_station = entry_station
        @exit_station = nil
        @in_journey = false
        @journey = {}
    end

    def in_journey?
        @in_journey
    end

    def entry
        @in_journey = true
        @journey[:entry_station] = @entry_station
    end

    def exit(exit_station)
        @exit_station = exit_station
        @in_journey = false
        @journey[:exit_station] = @exit_station
        fare
    end

    def fare
        Oystercard::MINIMUM_CHARGE
    end

end
