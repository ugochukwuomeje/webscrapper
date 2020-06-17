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

end