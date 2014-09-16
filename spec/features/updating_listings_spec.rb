require 'rails_helper'

feature 'Updating Listings' do
  let!(:user) { FactoryGirl.create(:user_with_address) }
  before do
    sign_in_as!(user)
    trees = FactoryGirl.create(:category, name: 'Trees')
    FactoryGirl.create(:subcategory, category: trees, name: 'Coniferous')
  end

end