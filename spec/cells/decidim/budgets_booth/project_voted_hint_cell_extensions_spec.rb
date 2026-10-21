# frozen_string_literal: true

require "spec_helper"

describe Decidim::BudgetsBooth::ProjectVotedHintCellExtensions do
  controller Decidim::Budgets::ProjectsController

  let(:organization) { create(:organization) }
  let(:component) { create(:budgets_component, organization:) }
  let(:budget) { create(:budget, component:) }
  let(:project) { create(:project, budget:) }
  let(:user) { create(:user, :confirmed, organization:) }
  let(:current_user) { user }

  describe "voted_for?" do
    context "when the user hasn't voted" do
      before do
        allow(controller).to receive(:voted_for?).with(project).and_return(false)
      end

      it "doesn't render hint" do
        cell = cell("decidim/budgets/project_voted_hint", project, context: { current_user: user }).call
        expect(cell).to have_no_css("svg")
        expect(cell).to have_no_css("div", text: "You voted for this")
      end
    end

    context "when the user has voted" do
      before do
        allow(controller).to receive(:voted_for?).with(project).and_return(true)
      end

      it "renders the hint" do
        cell = cell("decidim/budgets/project_voted_hint", project, context: { current_user: user }).call
        expect(cell).to have_css("svg")
        expect(cell).to have_css("div", text: "You voted for this")
      end
    end
  end

  describe "voted?" do
    before do
      allow(controller).to receive(:respond_to?).with(:voted_for?).and_return(false)
    end

    context "when the user hasn't voted" do
      before do
        allow(controller).to receive(:voted?).with(project).and_return(false)
      end

      it "doesn't render hint" do
        cell = cell("decidim/budgets/project_voted_hint", project, context: { current_user: user }).call
        expect(cell).to have_no_css("svg")
        expect(cell).to have_no_css("div", text: "You voted for this")
      end
    end

    context "when the user has voted" do
      let(:orders) { instance_double(ActiveRecord::Relation) }

      before do
        allow(controller).to receive(:current_user).and_return(current_user)
        allow(project).to receive(:orders).and_return(orders)
        allow(orders).to receive(:pluck).with(:decidim_user_id).and_return([user.id])
      end

      it "renders the hint" do
        cell = cell("decidim/budgets/project_voted_hint", project, context: { current_user: user }).call
        expect(cell).to have_css("svg")
        expect(cell).to have_css("div", text: "You voted for this")
      end
    end
  end
end
