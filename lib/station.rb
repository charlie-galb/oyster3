class Station
    attr_reader :st_name, :zone
    def initialize(st_name, zone)
        @st_name = st_name
        @zone = zone
    end
end