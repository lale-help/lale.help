require 'rails_helper'

describe "Create supply", js: true do
  
  let(:circle)        { create(:circle, :with_admin_and_working_group) }
  let(:admin)         { circle.admin }
  let(:working_group) { circle.working_groups.first }

  before { visit new_circle_supply_path(circle, as: admin) }

  let(:supply_form) { PageObject::Supply::Form.new }

  context "with minimal attributes" do
    let(:inputs) { attributes_for(:supply).merge(location: 'Munich') }
    it "creates the supply" do
      supply_page = supply_form.submit_with(inputs)
      expect(supply_page.name.text).to eq(inputs[:name])
      expect(supply_page.description.text).to eq(inputs[:description])
      expect(supply_page.location.text).to include(inputs[:location])
      expect(supply_page.due_date).to eq(inputs[:due_date])
     end
  end

  context "when no mandatory field is filled" do
    let(:inputs) { {} }
    it "shows all error messages" do
      supply_form.submit_with(inputs)
      expect(supply_form).to be_invalid
      expect(supply_form).to have_validation_error("Name can't be empty")
      expect(supply_form).to have_validation_error("Please enter a due date")
      expect(supply_form).to have_validation_error("Please enter a description")
      expect(supply_form).to have_validation_error("Please enter a location")
    end
  end
end
