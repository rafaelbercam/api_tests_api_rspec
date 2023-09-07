class UserServices
    include HTTParty
#debug_output $stdout
base_uri ENV['BASE_URL']
    def initialize
        @headers = {"Content-Type" => "application/json"}
    end
    
    def get_user
        self.class.get("/usuarios")
    end

    def get_user_by_id(id)
        self.class.get("/usuarios/#{id}", {:headers => @headers})
    end

    def create_user(body)
        self.class.post("/usuarios", {:headers => @headers, :body => body})
    end

    def update_user(id, body)
        self.class.put("/usuarios/#{id}", {:headers => @headers, :body => body})
    end

    def delete_user(id)
        self.class.delete("/usuarios/#{id}", {:headers => @headers})
    end

end