# frozen_string_literal: true

class FileImport < ApplicationRecord
  has_one_attached :file

  belongs_to :user
  belongs_to :store
end
