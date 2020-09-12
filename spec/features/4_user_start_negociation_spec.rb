require 'rails_helper'

feature 'User start negociation' do 
  scenario 'must be signed in' do 
    #Arrange
    #Act
    visit root_path
    click_on 'Produtos'
    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end
  scenario 'sucessfully' do 
    #Arrange
    user = User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678')
    other_user = User.create!(name:'Carlos Alberto', email:'carlos@sbt.com', password:'12345678')
    produto = Product.create!(name: 'Carro', price: '150000', description: 'O carro da sua vida, não encontrará nada melhor!', user: user )
    image_file = File.open( Rails.root.join('spec/support/bike.jpg'))
    produto.image.attach(io: image_file, filename: "bike.jpg", content_type: "image/png")
    comment_seller = Comment.create!(product: produto, user: user, text: 'Para começar o negócio crie um comentário', negociation: true )
    comment_buyer = Comment.create!(product: produto, user: other_user, text: 'Gostei bastante do carro, mas conseguimos negociar o valor', negociation: true)
    my_order = Order.create!(product: produto, user: other_user, comment: comment_seller, status: :negociation)
    #Act
    login_as(other_user, scope: :user)
    visit root_path
    click_on 'Produtos'
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
    expect(page).to have_content('Para começar o negócio crie um comentário')
    expect(page).to have_link('Voltar')
  end
end