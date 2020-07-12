require 'nokogiri'
require 'byebug'
require 'pry'
require 'colorize'

############# this is for including custom classes and modules
require_relative 'helperclass' # ##this is a helper class
require_relative 'getallurl' # this is a module

class Scrapper < Helperclass
  attr_reader :url

  def initialize(make, model)
    @make = make.capitalize
    @model = model.capitalize
    @url = "https://www.dupontregistry.com/autos/results/#{make}/#{model}/for-sale".sub(' ', '--')
  end

  include GetAllurl

  def scrape
    parsed_page = parse_url(@url)

    cars = parsed_page.css('div.searchResults') # Nokogiri object containing all cars on a given page

    cars_perpage = cars.count

    total_listings = parsed_page.css('#mainContentPlaceholder_vehicleCountWithin').text.to_i

    total_pages = get_number_of_pages(total_listings, cars_perpage)

    first_page = create_car_hash(cars)

    # create a method that links for other pages
    all_other = build_full_cars(total_pages)

    first_page + all_other.flatten
  end

  private

  # this create the car hash object from the parsed object
  def create_car_hash(car_obj)
    car_obj.map do |car|
      doc = car.css('span')[2].text

      { year: car.css('a').children[0].text[0..4].strip.to_i,
        name: @make,
        model: @model,
        price: doc, # .text.sub(",","").to_i,
        link: "https://www.dupontregistry.com/#{car.css('a').attr('href').value}" }
    end
  end

  def get_number_of_pages(listings, cars_per_page)
    a = listings % cars_per_page

    if a.zero?
      listings / cars_per_page
    else
      listings / cars_per_page + 1
    end
  end

  def build_full_cars(number_of_pages)
    a = [*2..number_of_pages]
    all_page_urls = get_all_page_urls(a)

    all_page_urls.map do |url|
      pu = parse_url(url)
      cars = pu.css('div.searchResults')
      create_car_hash(cars)
    end
  end
end
