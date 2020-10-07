require 'oystercard.rb'
describe Oystercard do
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

  describe '#in_journey' do
    it 'checks the class responds to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end

    it 'checks in_journey is false by default' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_in' do
    it 'checks that the touch_in method exists' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'checks that touch in changes journey status to true' do
      subject.top_up(1)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it 'check if the minimum amount is at least £1' do
      expect { subject.touch_in }.to raise_error "balance is not enough"
    end


  end

  describe '#touch_out' do
    it 'expects class to respond to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
    it 'checks the touch out method' do
      subject.top_up(1)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
  end

  it 'expects touch_out to change journey_status to false' do
    subject.top_up(1)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end

end
