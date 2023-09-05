# __Boilerplate API Tests with Rspec__

## __Ambiente__
Para executar os testes localmente, estou utilizando o ServeRest

<p align="left">
 <img alt="Logo do ServeRest" src="https://user-images.githubusercontent.com/29241659/115161869-6a017e80-a076-11eb-9bbe-c391eff410db.png" height="80">
</p>

Link do Repo: https://github.com/ServeRest/ServeRest

ServeRest está disponível de forma [online](https://serverest.dev), no [npm](https://www.npmjs.com/package/serverest) e no [docker](https://hub.docker.com/r/paulogoncalvesbh/serverest/).
```
npm install
```
Para iniciar o serviço basta acessar a pasta ServeRest-trunk rodar o comando
```
npx serverest@latest

```

## Pré Requisitos Rspec

- [Ruby > 2.7](https://www.ruby-lang.org/en/downloads/)


## Instalação

Clone project

- Clone este repositório para sua maquina usando http or ssh, por exemplo:

`git clone https://github.com/rafaelbercam/api_tests_api_rspec`

- Instale todas as dependências:


`bundle install`

## __Rodar os testes__
Basta rodar o comando
```
rspec spec/*.rb --format html --out rspec_results.html 
```

## __Configuração do Projeto__

O projeto esta dividido da seguinte maneira:



        [api_tests_api_rspec]
            [spec]
                [data] -> Classe Python responsável por criar objetos (payload) para as requisições
                [services] -> Classe que possui funções que retornam as requisições para a camada de testes
            env.rb -> Arquivo com variáveis de ambiente


### __data__
São classes que retornam objetos de acordo com os paramentros enviados em uma requisição.

Exemplo:

```ruby
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
```

### __services__

Em `services`, retornam a `Response` da requisição.

Exemplo da Classe:

```ruby
class UserServices
include HTTParty

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

end

```


### __spec__
Em ``spec``, poderão ser colocados os arquivos de teste no formato do Rspec.


Exemplo da classe:

```ruby
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
   
end


```
