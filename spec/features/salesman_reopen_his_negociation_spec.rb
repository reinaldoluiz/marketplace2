require 'rails_helper'

feature 'Salesman reopen his negociation' do 
  scenario 'sucessfully' do 
   #Arrange
   user = User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678')
   other_user = User.create!(name:'Carlos Alberto', email:'carlos@sbt.com', password:'12345678')
   produto = Product.create!(name: 'Carro',category:'Automóvel', price: '150000', description: 'O carro da sua vida, não encontrará nada melhor!', user: other_user )
   image_file = File.open( Rails.root.join('spec/support/bike.jpg'))
   produto.image.attach(io: image_file, filename: "bike.jpg", content_type: "image/png")
   #Act
   login_as(user, scope: :user)
   visit root_path
   click_on 'Meus Produtos'
   click_on 'Detalhes'
   click_on 'Negociar'
   #Assert
   expect(current_path).to eq  product_order_path(Product.last, Order.last)
   expect(page).to have_content('Carro')
   expect(page).to have_content('R$ 150.000,00')
   expect(page).to have_content('O carro da sua vida, não encontrará nada melhor!')
   expect(page).to have_content('Silvio Santos')
   expect(page).to have_content(user.name)
   expect(page).to have_css('img[src$="bike.jpg"]')
   expect(page).to have_content('Seu produto foi colocado novamente a venda')
   expect(page).to have_link('Voltar')
  end
end