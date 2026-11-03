# frozen_string_literal: true

module Decidim
  module BudgetsBooth
    module ProjectsControllerExtensions
      extend ActiveSupport::Concern
      include VotingSupport

      included do
        def index
          enforce_permission_to :read, :project
          raise ActionController::RoutingError, "Not Found" unless budget

          raise ActionController::RoutingError, "Not Found" unless allow_access?
        end

        def show
          raise ActionController::RoutingError, "Not Found" unless budget
          raise ActionController::RoutingError, "Not Found" unless project
          raise ActionController::RoutingError, "Not Found" unless allow_access?

          enforce_permission_to :read, :project, project:
        end
      end

      private

      def allow_access?
        return false if voting_booth_forced? && voting_enabled? && !voted_this?(budget)

        true
      end
    end
  end
end
