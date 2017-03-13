require 'spec_helper'

describe Slimdown::Page do

  before :each do
    Slimdown.config do |c|
      c.location = "#{fixtures_dir}/test_pages"
    end
  end

  it 'is sane' do
    Slimdown::Page.new("#{fixtures_dir}/test_pages/test.md")
  end

  it 'handles non-existant page' do
    expect {
      Slimdown::Page.new("#{fixtures_dir}/test_pages/bwahahaha.md")
    }.to raise_error Slimdown::Exception, 'Page not found'
  end

  describe '.find' do
    it 'handles root page' do
      page = Slimdown::Page.find('test')

      expect(page.title).to eql('A test slimdown title')
      expect(page.headers).to be_a(Hash)
      expect(page.headers['og-title']).to eql('This is only a test')
      expect(page.headers['og-image']).to eql('http://some.where.net/picture.png')
    end
  end

  describe '#siblings' do
    it 'works' do
      page = Slimdown::Page.find('test')

      siblings = page.siblings
      expect(siblings.count).to eql(3)
      expect(siblings[0].title).to be_nil
      expect(siblings[1].title).to eql('A test sibling title')
      expect(siblings[2].title).to eql('A test slimdown title')
    end
  end

  describe '#children' do
    it 'returns children' do
      page = Slimdown::Page.find('test')
      children = page.children
      expect(children.count).to eql(1)
      child = children.first
      expect(child.path).to eql('test/child')
      expect(child.title).to eql('A test child title')
    end

    it 'returns empty array when no children' do
      page = Slimdown::Page.find('test/child')
      children = page.children
      expect(children.count).to eql(0)
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
