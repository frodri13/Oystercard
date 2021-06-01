require 'oystercard'

RSpec.describe Oystercard do 
  it 'shows the balance of the card' do
    expect(subject.balance).to eq(0)
  end

  it 'can #top_up into the balance' do 
    subject.top_up
    expect(subject.balance).to eq(5)
  end

  it 'has a limit of 90' do 
    allow(subject).to receive(:balance_ok) { false }

    expect { subject.top_up }.to raise_error('The balance limit for this card is 90')
  end
end