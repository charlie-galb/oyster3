require 'journey.rb'

describe Journey do

    let(:mock_entry) { double :mock_entry}
    let(:mock_exit) { double :mock_exit}
    let(:card) {Oystercard.new}
    subject(:journey) { Journey.new(:mock_entry) }

    it "takes an entry station when starts a journey" do
      expect(journey.entry_station).to eq(:mock_entry)
    end

    it 'check touches in create a new journey' do
      card.top_up(5)
      expect(Journey).to receive(:new)
      card.touch_in(:mock_entry)
    end

    it "calculates the fare of the journey" do
      finish_journey = Journey.new(:mock_entry)
      expect(finish_journey.exit(:mock_exit)).to eq Oystercard::MINIMUM_CHARGE
    end

    it 'expects @in_journey to change to false after exit' do
      subject.entry
      subject.exit(:mock_exit)
      expect(subject.in_journey?).to be false
    end

    it 'checks @in_journey changes to true on entry' do
      subject.entry
      expect(subject.in_journey?).to eq(true)
    end

    it 'records the entry at the station' do
      subject.entry
      expect(subject.journey[:entry_station]).to eq(:mock_entry)
    end

    it 'records entry and exit stations' do
      subject.entry
      subject.exit(:mock_exit)
      expect(subject.journey[:exit_station]).to eq(:mock_exit)
    end
end
