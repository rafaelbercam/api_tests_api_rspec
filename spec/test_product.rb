require_relative 'services/product_services'
require_relative 'services/user_services'
require_relative 'services/login_services'
require_relative 'data/product_data'
require_relative 'data/user_data'
require_relative 'data/login_data'


describe 'Product Tests' do
    
    before(:all) do 
        @request_login = LoginServices.new()
        @product_data = ProductData.new()
        @login_data = LoginData.new()
        # create user for tests
        @user_data = UserData.new()
        @request_user = UserServices.new()
        @body_user = @user_data.create_user
        @response_user = @request_user.create_user(@body_user)
        expect(@response_user.code).to eq(201)
        expect(@response_user["message"]).to eq("Cadastro realizado com sucesso")
        # login Token
        @payload = JSON.parse(@body_user)
        @body_login = @login_data.create_login_data(@payload["email"], @payload["password"]) 
        @response_login = @request_login.post_login(@body_login)
        expect(@response_login.code).to eq(200)
        expect(@response_login["message"]).to eq("Login realizado com sucesso")
        @token = @response_login["authorization"]
        # initialize request
        @request = ProductServcices.new(@token)
    end
    
    it 'Should be a get request to /products' do
        @response = @request.get_products
        expect(@response.code).to eq(200)
    end
    
    it 'Should be able to create a product' do
        @product_body = @product_data.create_product
        @response = @request.post_product(@product_body)
        expect(@response.code).to eq(201)
        expect(@response["message"]).to eq("Cadastro realizado com sucesso")
    end
end