# frozen_string_literal: true

module Decidim
  module BudgetsBooth
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action unless permission_action.scope == :public

        user_data_action?

        permission_action
      end

      private

      def user_data_action?
        return false unless permission_action.subject == :user_data
        return false unless permission_action.action == :create

        toggle_allow(user.present?)
      end
    end
  end
end
