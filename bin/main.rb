require_relative '../lib/scrapper'
require 'colorize'

# This is web scrapping program the scrapes www.dupontregistry.com for the following information.
# www.dupontregistry.com is car ecommerce website where one can find information for expensive cars
# also make enquiries for the car.
# HOW THE PROGRAM WORKS

# 1 The program accepts two inputs (Make and model) and displays a list of the available cars on the site.

puts '+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                                                                                                 +
+  This is web scrapping program that gets information about all the bentley continental gt model +
+  from www.dupontregistry.com and displays them on the console                                   +
+                                                                                                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+'.yellow
carname = ''
carmaodel = ''
while carname == '' && carmaodel == ''
  puts 'Enter the the car name eg bentley'
  carname = gets.chomp

  puts 'Enter the the car model eg continental gt'
  carmodel = gets.chomp

  puts 'Please Wait while result is being fetched...'
end
carscrapper = Scrapper.new(carname.to_s, carmodel.to_s)
all_car_info = carscrapper.scrape

puts '-----------------------------------------------------------------------------------------------------------'.red
puts '    Name  |   Model       |  Price  | year | Link                                                          '.red
puts '-----------------------------------------------------------------------------------------------------------'.red

all_car_info.each do |car|
  name = car[:name]
  model = car[:model]
  price = car[:price]
  year = car[:year]
  link = car[:link]

  puts "| #{name} | #{model} | #{price}  | #{year} |#{link} |\n\n"
  puts '---------------------------------------------------------------------------------------------------------'
end
