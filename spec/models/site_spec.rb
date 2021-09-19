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
    describe "name is 'Le compost Masaryk '" do
      it "slug is 'composteur-masaryk'" do
        site = @organisation.sites.create(name: "Le compost Masaryk")
        expect(site.formatted_name).to eq("Composteur Masaryk")
        expect(site.slug).to eq("composteur-masaryk")
      end
    end
    describe "name is 'Compost Aristide Briand Caluire'" do
      it "slug is 'composteur-aristide-briand-caluire'" do
        site = @organisation.sites.create(name: "Compost Aristide Briand Caluire")
        expect(site.formatted_name).to eq("Composteur Aristide Briand Caluire")
        expect(site.slug).to eq("composteur-aristide-briand-caluire")
      end
    end
    describe "name is 'Ô Compost d'or'" do
      it "slug is 'composteur-o-compost-d-or'" do
        site = @organisation.sites.create(name: "Ô Compost d'or")
        expect(site.formatted_name).to eq("Composteur Ô Compost d'or")
        expect(site.slug).to eq("composteur-o-compost-d-or")
      end
    end
    describe "name is 'La République des Composteuses'" do
      it "slug is 'composteur-la-republique-des-composteuses'" do
        site = @organisation.sites.create(name: "La République des Composteuses")
        expect(site.formatted_name).to eq("Composteur La République des Composteuses")
        expect(site.slug).to eq("composteur-la-republique-des-composteuses")
      end
    end
    describe "name is 'TUBA Composte'" do
      it "slug is 'composteur-tuba-composte'" do
        site = @organisation.sites.create(name: "TUBA Composte")
        expect(site.formatted_name).to eq("Composteur TUBA Composte")
        expect(site.slug).to eq("composteur-tuba-composte")
      end
    end
  end
end
