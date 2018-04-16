# frozen_string_literal: true

class FileImportsController < ApplicationController
  # before_action :authenticate_user!

  def create
    store = Store.find(params['store_id'])
    authorize! :read, store

    if ['application/json', 'text/csv'].include?(params['file'].content_type)
      object_path = "variant_imports/#{current_user.id}/#{params['file'].original_filename}"
      object = S3_BUCKET.object(object_path)
      object.upload_file(params['file'].path)

      FileImportWorker.perform_async object_path, params['store_id']
    else
      render nothing: true, status: :unprocessable_entity
    end
  end
end
