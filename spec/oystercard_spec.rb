require 'oystercard'

RSpec.describe Oystercard do  
  let(:entry_station) { double(:station)}
  let(:exit_station) { double(:station) }
  let(:journey){ {entry: entry_station, exit: exit_station} }
 
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
    expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
  end

  it 'changes the value of in_journey? to "true" when using the #touch_in method' do
    allow(subject).to receive(:sufficient_funds?) { true } 
    
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to be_truthy
  end

  it 'changes the value of in_journey? to "false" when using the #touch_out method' do
    subject.touch_out(exit_station)

    expect(subject.in_journey?).to be_falsy
  end

  it 'raises an error when the card has insufficient funds' do
    allow(subject).to receive(:sufficient_funds?) { false }

    expect { subject.touch_in(entry_station) }.to raise_error("Insufficient funds! You need a minimum of $#{Oystercard::MINIMUM}")
  end

  it "charges the card the minimum fare of $#{Oystercard::MINIMUM}" do
    subject.top_up
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
  end

  describe 'interaction with stations' do
  

    it 'remembers the name of the station when using #touch_in' do
      allow(subject).to receive(:sufficient_funds?) { true } 
      subject.touch_in(entry_station)
      expect(subject.entry_station).to be(entry_station)
    end

    it 'stores an exit station' do
      allow(subject).to receive(:sufficient_funds?) { true } 
      
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      
      expect(subject.exit_station).to eq(exit_station)
    end

    it 'has an empty list of journeys' do
      expect(subject.journeys.length).to be_zero
    end

    it 'can store a journey' do
      allow(subject).to receive(:sufficient_funds?) { true } 
 
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject.journeys).to include(journey)
    end
  end
end