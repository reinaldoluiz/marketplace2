require 'rails_helper'

feature 'User see only his company product' do 
  scenario 'sucessfully' do 
    #Arrange
    company = Company.create!(name:'SBT')
    user1_sbt = User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678', company: company) 
    user2_sbt = User.create!(name:'Carlos Alberto', email:'carlos@sbt.com', password:'12345678',company: company)
    user3_sbt = User.create!(name:'Hebe Camargo', email:'hebe@sbt.com', password:'12345678', company: company)
    user1_globo = User.create!(name:'Luciano Huck', email:'luciano@globo.com', password:'12345678', company: company)
    user2_globo = User.create!(name:'Ana Maria Braga', email:'ana@globo.com', password:'12345678', company: company)
    user3_globo = User.create!(name:'Fausto Silva', email:'fausto@globo.com', password:'12345678', company: company)
    gol2020 = Product.create!(name: 'Gol 2020',category:'Automóvel', price: '150000', description: 'Zero Zero! Melhor oportunidade', user: user1_sbt )
    gol2018 = Product.create!(name: 'Gol 2018',category:'Automóvel', price: '100000', description: 'O carro mais economico da sua vida!', user: user2_sbt )
    celta2020 = Product.create!(name: 'Celta 2020',category:'Automóvel', price: '110000', description: 'A melhor escolha de todas!', user: user3_sbt )
    celta2018 = Product.create!(name: 'Celta 2018',category:'Automóvel', price: '120000', description: 'Vem com cd player!', user: user1_sbt )
    capitu = Product.create!(name: 'Capitu',category:'Livro', price: '1100', description: 'Clássico brasileiro!', user: user3_sbt )
    macunaima = Product.create!(name: 'Macunaima',category:'Livro', price: '1200', description: 'Super divertido!', user: user2_sbt )
    argo2020 = Product.create!(name: 'Argo 2020',category:'Automóvel', price: '150000', description: 'Zero Zero! Melhor oportunidade', user: user1_globo )
    argo2018 = Product.create!(name: 'Argo 2018',category:'Automóvel', price: '100000', description: 'O carro mais economico da sua vida!', user: user2_globo )
    golf2020 = Product.create!(name: 'Golf 2020',category:'Automóvel', price: '110000', description: 'A melhor escolha de todas!', user: user3_globo )
    golf2018 = Product.create!(name: 'Golf 2018',category:'Automóvel', price: '120000', description: 'Vem com cd player!', user: user1_globo )
    lenda = Product.create!(name: 'Lenda Negras',category:'Livro', price: '1100', description: 'Uma nova visão do mundo!', user: user3_globo )
    sonhos = Product.create!(name: 'Sonhos Perpétuos',category:'Livro', price: '1200', description: 'Super divertido!', user: user2_globo )
    #Act
    login_as(user1_sbt, scope: :user)
    visit root_path 
    click_on 'Produtos'

    #Assert
    expect(current_path).to eq products_path
    expect(page).to have_content('Gol 2020')
    expect(page).to have_content('Gol 2018')
    expect(page).to have_content('Celta 2020')
    expect(page).to have_content('Celta 2018')
    expect(page).to have_content('Capitu')
    expect(page).to have_content('Macunaima')
    expect(page).to have_content(user1_sbt.name)
    expect(page).to have_content(user2_sbt.name)
    expect(page).not_to have_content('Argo 2020')
    expect(page).not_to have_content('Argo 2018')
    expect(page).not_to have_content('Golf 2020')
    expect(page).not_to have_content('Golf 2018')
    expect(page).not_to have_content('Lenda Negras')
    expect(page).not_to have_content('Sonhos Perpétuos')
    expect(page).not_to have_content(user1_globo.name)
    expect(page).not_to have_content(user2_globo.name)
  end
end