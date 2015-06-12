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

  describe '#siblings' do
    it 'works' do
      page = Slimdown::Page.find('test')

      siblings = page.siblings
      expect(siblings.count).to eql(2)
      expect(siblings[0].title).to eql('A test sibling title')
      expect(siblings[1].title).to eql('A test slimdown title')
    end
  end

  describe '#path' do
    it 'works at root level' do
      page = Slimdown::Page.find('test')
      expect(page.path).to eql('test')
    end

    it 'works at child level' do
      page = Slimdown::Page.find('test/child')
      expect(page.path).to eql('test/child')
    end
  end
end
