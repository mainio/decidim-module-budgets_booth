# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Shakapacker.register_path("#{base_path}/app/packs", prepend: true)
Decidim::Shakapacker.register_entrypoints(
  decidim_budgets_booth_voting: "#{base_path}/app/packs/entrypoints/decidim_budgets_booth_voting.js",
  decidim_budgets_booth_zip_code: "#{base_path}/app/packs/entrypoints/decidim_budgets_booth_zip_code.js",
  decidim_handle_voting_complete: "#{base_path}/app/packs/entrypoints/decidim_handle_voting_complete.js",
  decidim_budgets_booth_show_projects: "#{base_path}/app/packs/entrypoints/decidim_budgets_booth_show_projects.js"
)

Decidim::Shakapacker.register_stylesheet_import("stylesheets/decidim/budgets_booth/budgets_booth")
