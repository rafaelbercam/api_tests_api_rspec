class ProductData
    def create_product
        @nome = Faker::Commerce.product_name
        @preco = Faker::Number.between(from: 22, to: 150)
        @descricao = "Material: #{Faker::Commerce.material}, Marca: #{Faker::Commerce.brand}, Fabricante: #{Faker::Commerce.vendor}"
        @quantidade = Faker::Number.between(from: 10, to: 100)
      
        return JSON.generate({
          :nome => @nome,
          :preco => @preco,
          :descricao => @descricao,
          :quantidade => @quantidade
        })
    end
end