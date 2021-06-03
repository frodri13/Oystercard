require 'oystercard'

RSpec.describe Oystercard do  
  let(:station) { double(:station, name: "name of the station")}
 
  it 'shows the balance of the card' do
    expect(subject.balance).to be_zero
  end

  it 'can #top_up into the balance' do 
    subject.top_up
    expect(subject.balance).to eq(Oystercard::DEFAULT)
  end

 
  # it { subject.top_up(1) }.to change{ subject.balance}.by(1)}
 
  it "can raise an error when balance over #{Oystercard::LIMIT}" do
    allow(subject).to receive(:balance_ok?) { false }

    expect { subject.top_up }.to raise_error("The balance limit for this card is #{Oystercard::LIMIT}")
  end

  it 'deducts money from card\'s balance' do
    subject.top_up
    expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
  end

  it 'changes the value of in_journey? to "true" when using the #touch_in method' do
    allow(subject).to receive(:sufficient_funds?) { true } 
    
    subject.touch_in(station)
    expect(subject.in_journey?).to be_truthy
  end

  it 'changes the value of in_journey? to "false" when using the #touch_out method' do
    subject.touch_out

    expect(subject.in_journey?).to be_falsy
  end

  it 'raises an error when the card has insufficient funds' do
    allow(subject).to receive(:sufficient_funds?) { false }

    expect { subject.touch_in(station) }.to raise_error("Insufficient funds! You need a minimum of $#{Oystercard::MINIMUM}")
  end

  it "charges the card the minimum fare of $#{Oystercard::MINIMUM}" do
    subject.top_up
    subject.touch_in(station)
    expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
  end

  describe 'interaction with stations' do

    it 'remembers the name of the station when using #touch_in'do
      allow(subject).to receive(:sufficient_funds?) { true } 
      
      subject.touch_in(station)
      expect(subject.entry_station).not_to be_nil
    end
  end

end