require 'oystercard'

RSpec.describe Oystercard do 
  it 'shows the balance of the card' do
    expect(subject.balance).to eq(0)
  end

  it 'can #top_up into the balance' do 
    subject.top_up
    expect(subject.balance).to eq(5)
  end
end