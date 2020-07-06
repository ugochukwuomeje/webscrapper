require_relative '../scrapper.rb'

describe Scrapper do
  describe '#get_number_of_pages' do
    it 'it gets the number of pages that has bently continental' do
      scrape = Scrapper.new('bentley', 'continental gt')
      expect(scrape.get_number_of_pages(100, 6)).to equal(17)
    end
  end

  describe '#parse_url' do
    it 'it get the parsed page and displays the number ' do
      scrape = Scrapper.new('bentley', 'contnental gt')
      parsed_page = scrape.parse_url(scrape.url)
      cars = parsed_page.css('div.searchResults')
      expect(cars.count).to equal(10)
    end
  end

  describe '#scrape' do
    it "this method gets the number of cars with model  name 'bentley' and model 'continental gt' " do
      allcars = Scrapper.new('bentley', 'contnental gt')
      expect(allcars.scrape.length).to equal(480)
    end
  end
end
