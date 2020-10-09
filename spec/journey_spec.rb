require 'journey.rb'

describe Journey do
    let(:entry_station) { double :entry_station}
    let(:exit_station) { double :exit_station}
    
    let(:card) {Oystercard.new}

    it "takes an entry station when starts a journey" do
        start_journey = Journey.new(:entry_station)
        expect(start_journey.entry_station).to eq :entry_station
    end

    it 'check touches in create a new journey' do
        # card = Oystercard.new
        card.top_up(5)
        expect(Journey).to receive(:new)
        card.touch_in(:entry_station)
    end

    it "calculates the fare of the journey" do
        finish_journey = Journey.new(:entry_station)
        expect(finish_journey.exit(:exit_station)).to eq Oystercard::MINIMUM_CHARGE
    end

    it 'expects touch_out to change journey status to false' do
        allow(:card).to receive(:touch_in).and_return()
        # card = Oystercard.new
        card.top_up(1)
        card.touch_in(:entry_station)
        card.exit(:exit_station)
        expect(card.in_journey?).to eq(false)
      end


end