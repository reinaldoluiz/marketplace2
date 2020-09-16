require 'rails_helper'

feature 'User comment in negociation' do 
  scenario 'sucessfully' do 
    #Arrange
    user = User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678')
    other_user = User.create!(name:'Carlos Alberto', email:'carlos@sbt.com', password:'12345678')
    produto = Product.create!(name: 'Carro',category:'Automóvel', price: '150000', description: 'O carro da sua vida, não encontrará nada melhor!', user: user )
    image_file = File.open( Rails.root.join('spec/support/bike.jpg'))
    produto.image.attach(io: image_file, filename: "bike.jpg", content_type: "image/png")
    my_order = Order.create!(product_id: produto.id, user: other_user, status: :negociation)
    #Act
    login_as(other_user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Detalhes'
    click_on 'Negociar'
    fill_in 'comment[body]', with: "Gostei do carro, vamo fechar por 30% do preço!"
    click_on 'Criar Comentário'
    #Assert
    
    expect(current_path).to eq order_path(my_order.id)
    expect(page).to have_content('Carro')
    expect(page).to have_content('R$ 150.000,00')
    expect(page).to have_content('O carro da sua vida, não encontrará nada melhor!')
    expect(page).to have_content('Silvio Santos')
    expect(page).to have_content(user.name)
    expect(page).to have_content(other_user.name)
    expect(page).to have_content('Gostei do carro, vamo fechar por 30% do preço!')
    expect(page).to have_css('img[src$="bike.jpg"]')
    expect(page).to have_link('Voltar')
  end
end