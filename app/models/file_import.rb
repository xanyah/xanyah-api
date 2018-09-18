# frozen_string_literal: true

class FileImport < ApplicationRecord
  has_one_attached :file

  belongs_to :user
  belongs_to :store

  after_create :start_worker

  protected

  def start_worker
    FileImportWorker.perform_async id
  end
end
