require 'spec_helper'

describe Slimdown::Page do

  before :each do
    Slimdown.config do |c|
      c.location = "#{fixtures_dir}/test_pages"
    end
  end

  it 'is sane' do
    page = Slimdown::Page.new("#{fixtures_dir}/test_pages/pages/test.md")
  end

  describe '.find' do
    it 'handles root page' do
      page = Slimdown::Page.find('test')

      expect(page.title).to eql('A test slimdown title')
    end
  end
end
