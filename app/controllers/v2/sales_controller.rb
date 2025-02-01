# frozen_string_literal: true

module V2
  class SalesController < ResourcesController
    def create
      @record = model_class.new(permitted_attributes(model_class))
      @record.user = current_user
      super
    end

    def included_relationships
      %i[customer user]
    end
  end
end
