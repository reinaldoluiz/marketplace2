require 'rails_helper'

feature 'User create new product' do 
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
    
    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Criar novo produto'

    fill_in 'Nome', with: 'Carro'
    fill_in 'Categoria', with: 'Automovél'
    fill_in 'Preço', with: '150000'
    fill_in 'Descrição', with: 'O carro da sua vida, não encontrará nada melhor!'
    attach_file 'Imagem', Rails.root.join('spec/support/bike.jpg')
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq product_path(Product.last)
    expect(page).to have_content('Carro')
    expect(page).to have_content('R$ 150.000,00')
    expect(page).to have_content('O carro da sua vida, não encontrará nada melhor!')
    expect(page).to have_content('Silvio Santos')
    expect(page).to have_content('Automovél')
    expect(page).to have_css('img[src$="bike.jpg"]')
    expect(page).to have_link('Voltar')
  end
end