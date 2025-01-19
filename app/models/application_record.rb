# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  acts_as_paranoid

  self.abstract_class = true

  def self.ransackable_attributes(_auth_object = nil)
    column_names + _ransackers.keys
  end

  def self.ransackable_associations(_auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s } + _ransackers.keys
  end
end
