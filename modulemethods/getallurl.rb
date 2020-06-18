module GetAllurl
    def get_all_page_urls(array_of_ints)
        array_of_ints.map { |number| 
         @url + "/pagenum=#{number}" }
    end 
end