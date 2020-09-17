require 'rails_helper'

feature 'User search product by category' do 
  scenario 'sucessfully' do 

    user1 = User.create!(name:'Silvio Santos', email:'silvio@sbt.com', password:'12345678')
    user2 = User.create!(name:'Hebe Camargo', email:'hebe@sbt.com', password:'12345678')
    user3 = User.create!(name:'Carlos Alberto', email:'carlos@sbt.com', password:'12345678')
    gol2020 = Product.create!(name: 'Gol 2020',category:'Automóvel', price: '150000', description: 'Zero Zero! Melhor oportunidade', user: user1 )
    gol2018 = Product.create!(name: 'Gol 2018',category:'Automóvel', price: '100000', description: 'O carro mais economico da sua vida!', user: user2 )
    celta2020 = Product.create!(name: 'Celta 2020',category:'Automóvel', price: '110000', description: 'A melhor escolha de todas!', user: user3 )
    celta2018 = Product.create!(name: 'Celta 2018',category:'Automóvel', price: '120000', description: 'Vem com cd player!', user: user1 )
    capitu = Product.create!(name: 'Capitu',category:'Livro', price: '1100', description: 'Clássico brasileiro!', user: user3 )
    macunaima = Product.create!(name: 'Macunaima',category:'Livro', price: '1200', description: 'Super divertido!', user: user2 )

    visit root_path 
    fill_in 'Busca', with: 'Automóvel'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Gol 2020')
    expect(page).to have_content('Gol 2018')
    expect(page).to have_content('Celta 2020')
    expect(page).to have_content('Celta 2018')
    expect(page).not_to have_content('Capitu')
    expect(page).not_to have_content('Macunaima')

  end
end
