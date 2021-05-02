require 'rails_helper'
RSpec.describe Site, :type => :model do
  context "name changes" do

    before(:all) do
      user = create(:user, email: 'testing@gmail.com', password: 'password')
      @organisation = create(:organisation, name: 'Collectif test', user_id: user.id)
    end

    describe "name is 'Compost Bahadourian (de la Guill)'" do
      it "slug is 'composteur-bahadourian-de-la-guill'" do
        site = @organisation.sites.create(name: "Compost Bahadourian (de la Guill)")
        expect(site.formatted_name).to eq("Composteur Bahadourian (de la Guill)")
        expect(site.slug).to eq("composteur-bahadourian-de-la-guill")
      end
    end
    describe "name is 'Compostage Potakin'" do
      it "slug is 'composteur-potakin'" do
        site = @organisation.sites.create(name: "Compostage Potakin")
        expect(site.formatted_name).to eq("Composteur Potakin")
        expect(site.slug).to eq("composteur-potakin")
      end
    end
    describe "name is 'Composteur ATOME Village'" do
      it "slug is 'composteur-atome-village'" do
        site = @organisation.sites.create(name: "Composteur ATOME Village")
        expect(site.formatted_name).to eq("Composteur ATOME Village")
        expect(site.slug).to eq("composteur-atome-village")
      end
    end
    describe "name is 'Clos de Fourvière'" do
      it "slug is 'composteur-clos-de-fourviere'" do
        site = @organisation.sites.create(name: "Clos de Fourvière")
        expect(site.formatted_name).to eq("Composteur Clos de Fourvière")
        expect(site.slug).to eq("composteur-clos-de-fourviere")
      end
    end
  end
end
