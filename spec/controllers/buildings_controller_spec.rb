require "rails_helper"

RSpec.describe BuildingsController do
  specify { expect(get: '/').to route_to(controller: "buildings", action: "index") }
  specify { expect(get: '/search').to route_to(controller: "buildings", action: "search") }

  describe 'GET #index' do
    subject { get :index }

    it 'success' do
      is_expected.to be_successful
    end

    it 'renders template' do
      is_expected.to render_template :index, lauout: :application
    end
  end

  describe 'GET #search' do
    subject { get :search, params: { lon: 0, lat: 0 } }

    it 'success' do
      is_expected.to be_successful
    end

    it 'renders template' do
      is_expected.to render_template :search, layout: nil
    end
  end
end
