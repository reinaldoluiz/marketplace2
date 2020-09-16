require 'rails_helper'

describe Product, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product = Product.new

      product.valid?

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:category]).to include('não pode ficar em branco')
      expect(product.errors[:price]).to include('não pode ficar em branco')
      expect(product.errors[:description]).to include('não pode ficar em branco')

    end

    it 'name must be uniq' do
      Product.create!(name: 'Fusca', category:'Carro', price: '12345646', description: '')
      product = Product.new(name: 'Fusca')

      product.valid?

      expect(product.errors[:name]).to include('já está em uso')
    end
  end
end
  
