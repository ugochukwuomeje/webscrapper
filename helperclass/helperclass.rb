class Helperclass
     
    #this method get the raw html and parse the raw html with nokogiri to convert the html to ruby objects
     def parse_url(url)
        unparsed_page = HTTParty.get(url)
        Nokogiri::HTML(unparsed_page)
    end 

    
end