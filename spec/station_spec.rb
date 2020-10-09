require 'station.rb'

describe Station do
    it 'checks that variable station name was created' do
        name = Station.new('Bank', 'Zone 1')
        expect(name.st_name).to eq ('Bank')
    end

    it 'checks that variable zone was created' do
        number = Station.new('Bank', 'Zone 1')
        expect(number.zone).to eq ('Zone 1')
    end

end