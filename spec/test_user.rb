require_relative 'services/user_services'
require_relative 'data/user_data'

describe "User Tests" do
  
    before(:all) do
      @user_data = UserData.new()
      @request = UserServices.new()
    end

    it 'get /usuarios hould return a 200 status code' do
      response = @request.get_user
      expect(response.code).to eq(200)
    end

    it 'create user hould return a 201 status code' do
      @body = @user_data.create_user
      response = @request.create_user(@body)
      expect(response.code).to eq(201)
      expect(response["message"]).to eq("Cadastro realizado com sucesso")
    end

    it 'update user hould return a 200 status code' do
      # create user
      @body = @user_data.create_user
      response = @request.create_user(@body)
      expect(response.code).to eq(201)
      expect(response["message"]).to eq("Cadastro realizado com sucesso")
      id = response["_id"]
      # updated user created
      @body = @user_data.create_user
      response = @request.update_user(id, @body)
      expect(response.code).to eq(200)
      expect(response["message"]).to eq("Registro alterado com sucesso")
    end

    it 'get user by id hould return a 200 status code' do 
       # create user
       body = @user_data.create_user
       response = @request.create_user(body)
       expect(response.code).to eq(201)
       expect(response["message"]).to eq("Cadastro realizado com sucesso")
       id = response["_id"]
       # get user by id
       @body = JSON.parse(body)
       response = @request.get_user_by_id(id)
       expect(response.code).to eq(200)
       expect(response["nome"]).to eq(@body["nome"])
       expect(response["email"]).to eq(@body["email"])
    end

    it 'delete user hould return a 200 status code' do
       # create user
       body = @user_data.create_user
       response = @request.create_user(body)
       expect(response.code).to eq(201)
       expect(response["message"]).to eq("Cadastro realizado com sucesso")
       id = response["_id"]
       # delete user by id
       @body = JSON.parse(body)
       response = @request.delete_user(id)
       expect(response.code).to eq(200)
       expect(response["message"]).to eq("Registro excluído com sucesso")
    end
   
end
