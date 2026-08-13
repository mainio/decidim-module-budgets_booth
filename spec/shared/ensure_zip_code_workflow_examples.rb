# frozen_string_literal: true

shared_examples "ensure zip code workflow" do
  it "redirects user to root path" do
    expect(page).to have_current_path "/en"
    within_flash_messages do
      expect(page).to have_content "You are not allowed to perform this action."
    end
  end
end
