require 'nokogiri'
require 'rest-client'
require 'httparty'
require 'byebug'
require 'pry'

class Scraper < Helperclass

        attr_reader :url, :make, :model

        def initialize (make, model)
            @make = make.capitalize
            @model = model.capitalize
            @url = "https://www.dupontregistry.com/autos/results/#{make}/#{model}/for-sale".sub(" ", "--")
        end 

        #this method get the raw html and parse the raw html with nokogiri to convert the html to ruby objects
        def parse_url(url)
            unparsed_page = HTTParty.get(url)
            Nokogiri::HTML(unparsed_page)
        end 

        def scrape 
            parsed_page = parse_url(@url)
           
             cars = parsed_page.css('div.searchResults') #Nokogiri object containing all cars on a given page
           
            
        end 

        #this create the car hash object from the parsed object
        def create_car_hash(car_obj)

            car_obj.map { |car|
        
            { year: car.css('a').children[0].text[0..4].strip.to_i,
                name: @make,
                model: @model,
                price: car.css('.cost').children[1].text.sub(",","").to_i,
                link: "https://www.dupontregistry.com/#{car.css('a').attr('href').value}" }
            }
        end 
end