class UserData
    def create_user
        @first_name = Faker::Name.first_name
        @last_name = Faker::Name.last_name
        @email = "#{@first_name}.#{@last_name}@email.com".downcase
        @password = Faker::Internet.password
      
        return JSON.generate({
          :nome => "#{@first_name} #{@last_name}",
          :email => @email,
          :password => @password,
          :administrador => "true"
        })
      end
end