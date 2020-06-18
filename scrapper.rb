require 'nokogiri'
require 'rest-client'
require 'httparty'
require 'byebug'
require 'pry'

############# this efor including custom classes and modules


class Scraper < Helperclass

        attr_reader :url, :make, :model

        def initialize (make, model)
            @make = make.capitalize
            @model = model.capitalize
            @url = "https://www.dupontregistry.com/autos/results/#{make}/#{model}/for-sale".sub(" ", "--")
        end 

        def scrape 
            parsed_page = parse_url(@url)
           
             cars = parsed_page.css('div.searchResults') #Nokogiri object containing all cars on a given page
           
             first_page = create_car_hash(cars)

             #create a method that links for other pages
             all_other = build_full_cars(total_pages)

             first_page + all_other.flatten
            
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

       

        def get_number_of_pages(listings, cars_per_page)
            a = listings % cars_per_page
            if a == 0
               listings / cars_per_page
            else 
               listings / cars_per_page + 1
            end 
        end 

        def build_full_cars(number_of_pages)
            a = [*2..number_of_pages]
            all_page_urls = get_all_page_urls(a)
           
            all_page_urls.map { |url| 
            pu = parse_url(url)
            cars = pu.css('div.searchResults')
            create_car_hash(cars) }
        end

        
end