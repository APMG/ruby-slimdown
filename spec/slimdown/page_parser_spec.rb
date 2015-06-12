require 'spec_helper'

describe Slimdown::PageParser do

  let(:markdown_html) { "\n<p>This is a test markdown page.</p>\n\n<h1 id=\"header\">Header!!!</h1>\n\n" }

  it 'parses a page' do
    page = Slimdown::PageParser.new("#{fixtures_dir}/test_pages/pages/test.md")

    headers = page.headers
    expect(headers['title']).to eql('A test slimdown title')

    body = page.body
    expect(body.to_html).to eql(markdown_html)
  end
end