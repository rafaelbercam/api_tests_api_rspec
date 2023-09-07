class ProductServcices
    include HTTParty
    debug_output $stdout
    base_uri ENV['BASE_URL']

    def initialize(token)
        @headers = {  'Content-Type' => 'application/json', 'Authorization' => token}
    end

    def get_products 
        self.class.get('/produtos', :headers => @headers)
    end

    def post_product(product)
        self.class.post('/produtos', :body => product, :headers => @headers)
    end
end