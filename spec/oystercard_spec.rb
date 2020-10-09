require 'oystercard.rb'
describe Oystercard do

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  let(:mock_entry) { double :mock_entry}
  let(:mock_exit) { double :mock_exit}

  it 'checks that the oystercard has an initial value of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'checks the increase balance in the card' do
      expect { subject.top_up 5 }.to change {subject.balance }.by 5
    end

    context 'when topped up' do
      before do
        subject.top_up(Oystercard::BALANCE_LIMIT)
      end

      it 'raises error when trying to top up to be more than £90' do
        expect { subject.top_up 91 }.to raise_error('You cannot have more than £90 in your balance')
      end
    end
  end

  describe '#touch_in' do
    it 'checks that the touch_in method exists' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'check if the minimum amount is at least £1' do
      expect { subject.touch_in 1 }.to raise_error "balance is not enough"
    end
  end

  describe '#touch_out' do
    it 'expects class to respond to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
    it 'checks the touch out method' do
      subject.top_up(1)
      subject.touch_in(1)
      expect{ subject.touch_out 1 }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
    # it 'check that is not in journey' do
    #   subject.top_up(1)
    #   subject.touch_in(:station)
    #   subject.touch_out(:station)
    #   expect(subject).to eq in_journey
    # end
  end

  describe 'add journeys history' do
    it 'checks that the array of journeys is empty' do
      expect(subject.journeys_history).to eq []
    end

    it 'stores a journey' do
      subject.top_up(2)
      subject.touch_in(:mock_entry)
      subject.touch_out(:mock_exit)
      print subject.journeys_history
      expect(subject.journeys_history).to eq [{:entry_station=>:mock_entry, :exit_station=>:mock_exit}]
    end
  end
end
