require 'spec_helper'
require 'models/cellar_list'

describe CellarList do

  context 'building a list' do
    let!(:users) { FactoryGirl.create_list(:user, 2) }

    it 'can be paginated' do
      list = described_class.new
      expect(list.count).to eq(2)
      expect(list.current_page).to eq(1)

      list = described_class.new(page: 1, per_page: 1)
      expect(list.count).to eq(1)
      expect(list.current_page).to eq(1)

      list = described_class.new(page: 3, per_page: 1)
      expect(list.count).to eq(0)
      expect(list.total_pages).to eq(2)
    end
  end
end
