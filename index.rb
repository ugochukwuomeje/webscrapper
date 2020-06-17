class Index
    # This is web scrapping program the scrapes www.dupontregistry.com for the following information.
    # www.dupontregistry.com is car ecommerce website where one can find information for expensive cars 
    # also make enquiries for the car.
    # HOW THE PROGRAM WORKS

    #1 The program accepts two inputs (Make and model) and displays a list of the available cars on the site.
  
    def getcarInfor
        puts"ENTER THE CAR MAKE"
        car_make = gets

        puts"ENTER THE CAR MODEL"
        car_model = gets
    end

    
end

Index.new().getcarInfor