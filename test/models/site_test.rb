# require "minitest/autorun"
require 'test_helper'
require 'support/database_cleaner'

class SiteTest < ActiveSupport::TestCase
  describe "name changes" do
    before do
      @organisation = Organisation.create(name: 'test')
    end
    describe "name is 'Compost Bahadourian (de la Guill)'" do
      it "slug is 'composteur-bahadourian-de-la-guill'" do
        site = @organisation.sites.create(name: "Compost Bahadourian (de la Guill)")
        assert site.formatted_name == "Composteur Bahadourian (de la Guill)"
        assert site.slug == "composteur-bahadourian-de-la-guill"
      end
    end
    describe "name is 'Compostage Potakin'" do
      it "slug is 'composteur-potakin'" do
        site = @organisation.sites.create(name: "Compostage Potakin")
        assert site.formatted_name == "Composteur Potakin"
        assert site.slug == "composteur-potakin"
      end
    end
    describe "name is 'Composteur ATOME Village'" do
      it "slug is 'composteur-atome-village'" do
        site = @organisation.sites.create(name: "Composteur ATOME Village")
        assert site.formatted_name == "Composteur ATOME Village"
        assert site.slug == "composteur-atome-village"
      end
    end
    describe "name is 'Clos de Fourvière'" do
      it "slug is 'composteur-clos-de-fourviere'" do
        site = @organisation.sites.create(name: "Clos de Fourvière")
        assert site.formatted_name == "Composteur Clos de Fourvière"
        assert site.slug == "composteur-clos-de-fourviere"
      end
    end
  end
end
