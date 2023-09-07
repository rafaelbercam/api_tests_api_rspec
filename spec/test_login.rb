require_relative 'services/user_services'
require_relative 'services/login_services'
require_relative 'data/user_data'
require_relative 'data/login_data'

describe "Login Tests" do
    before(:all) do
        @request = LoginServices.new()
        @login_data = LoginData.new()
        # create user for tests
        @user_data = UserData.new()
        @request_user = UserServices.new()
        @body = @user_data.create_user
        @response_user = @request_user.create_user(@body)
        expect(@response_user.code).to eq(201)
        expect(@response_user["message"]).to eq("Cadastro realizado com sucesso")
        # create login_data
        @payload = JSON.parse(@body)
    end

    it "should a success login" do
        @body_login = @login_data.create_login_data(@payload["email"], @payload["password"]) 
        @response_login = @request.post_login(@body_login)
        expect(@response_login.code).to eq(200)
        expect(@response_login["message"]).to eq("Login realizado com sucesso")
    end

    it "should a failure login" do
        @body_login = @login_data.create_login_data(@payload["email"], "123456") 
        @response_login = @request.post_login(@body_login)
        expect(@response_login.code).to eq(401)
        expect(@response_login["message"]).to eq("Email e/ou senha inválidos")
    end

    it "should a failure login without email" do
        @body_login = @login_data.create_login_data("", @payload["password"]) 
        @response_login = @request.post_login(@body_login)
        expect(@response_login.code).to eq(400)
        expect(@response_login["email"]).to eq("email não pode ficar em branco")
    end
end