require 'rails_helper'

feature 'Visitor visits' do
  scenario 'home page' do
    visit root_path
    expect(page).to have_title('Compost Lyon - tout sur le compost à Lyon')
  end
  scenario 'about page' do
    visit about_path
    expect(page).to have_title('Compost Lyon - Le projet')
  end
  scenario 'collective composting page' do
    visit collective_composting_path
    expect(page).to have_title('Compostage collectif à Lyon')
  end
  scenario 'sites index' do
    visit sites_path
    expect(page).to have_title('Composteurs collectifs de quartier de Lyon et des environs')
  end
  scenario 'condominium sites index' do
    visit condominium_sites_path
    expect(page).to have_title('Composteurs collectifs de copropriété à Lyon')
  end
  scenario 'organisations index' do
    visit collective_composting_organisations_path
    expect(page).to have_title('Compostage collectif - les acteurs')
  end
end
