require './scrapper'
require 'byebug'
class Index
  # This is web scrapping program the scrapes www.dupontregistry.com for the following information.
  # www.dupontregistry.com is car ecommerce website where one can find information for expensive cars
  # also make enquiries for the car.
  # HOW THE PROGRAM WORKS

  # 1 The program accepts two inputs (Make and model) and displays a list of the available cars on the site.

  def car_infor
    puts 'ENTER THE CAR MAKE'
    car_make = gets.strip

    puts 'ENTER THE CAR MODEL'
    car_model = gets.strip

    all_car_info = getallcars(car_make, car_model)

    # number_of_cars = all_car_info.length

    all_car_info.each do |car|
      puts car
      puts ' '
    end
  end

  private

  def getallcars(make, model)
    carscrapper = Scrapper.new(make, model)

    carscrapper.scrape
  end
end

cars = Index.new
cars.car_infor
# cars.("bentley", "continental gt")
