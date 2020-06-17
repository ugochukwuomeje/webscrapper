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

end