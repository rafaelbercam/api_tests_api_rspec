class LoginData
    def create_login_data(email, password)
        
        @email = email
        @password = password
      
        return JSON.generate({
          :email => @email,
          :password => @password,
        })
      end
end