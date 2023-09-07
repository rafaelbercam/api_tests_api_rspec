class LoginServices
    include HTTParty
    #debug_output $stdout
    base_uri ENV['BASE_URL']

    def initialize
        @headers = {"Content-Type" => "application/json"}
    end

    def post_login(body)
        self.class.post("/login", :body=> body, :headers=> @headers)
    end
end
