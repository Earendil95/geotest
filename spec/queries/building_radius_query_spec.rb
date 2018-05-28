require 'rails_helper'

RSpec.describe BuildingRadiusQuery do
  describe '#in_radius' do
    before_all do
      create :building, address: "Level.Travel", longitude: 37.691284, latitude: 55.779324
      create :building, address: "All Your Friends", longitude: 37.606751, latitude: 55.762684
      create :building, address: "Alexander Garden", longitude: 37.615439, latitude: 55.754065
    end

    let(:radius) { nil }

    subject(:result) { described_class.new(37.617635, 55.755814).in_radius(radius) }

    it "returns only 'close' points" do
      expect(result.count(:all)).to eq 2
    end

    it "orders buildings by distance" do
      expect(result.first.address).to eq "Alexander Garden"
    end

    context 'with custom radius' do
      let(:radius) { 500 }

      it "returns only points in custom radius" do
        expect(result.count(:all)).to eq 1
        expect(result.first.address).to eq "Alexander Garden"
      end
    end
  end
end
