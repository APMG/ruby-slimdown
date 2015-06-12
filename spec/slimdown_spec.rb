require 'spec_helper'

describe Slimdown do
  it 'has a version number' do
    expect(Slimdown::VERSION).not_to be nil
  end

  describe '.config' do
    it 'manages configuration' do
      config = Slimdown.config do |c|
        c.location = 'blahblahblah'
      end

      expect(config.location).to eql('blahblahblah')
    end

    it 'returns config after setting it' do
      Slimdown.config do |c|
        c.location = 'blahblahblah'
      end

      config = Slimdown.config
      expect(config.location).to eql('blahblahblah')
    end
  end
end
