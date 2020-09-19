require 'rails_helper'

feature 'User sign-in' do 
  scenario 'from home page' do 
    #Arrange

    #Act
    visit root_path

    #Assert
    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do 
    #Arrange
    User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'silvio@sbt.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Acessar'

    #Assert
    expect(page).to have_content 'Silvio Santos'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link  'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'and sign out' do 
    #Arrange
    user = User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Sair'

    #Assert
    expect(page).to have_content('Entrar')
  
  end
end