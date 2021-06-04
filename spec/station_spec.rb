require 'station'

RSpec.describe Station do
  subject { described_class.new("Waterloo" , 1) }

  it 'has a name' do
    expect(subject.name).to eq("Waterloo")
  end

  it 'has a zone' do
    expect(subject.zone).to eq(1)
  end
end