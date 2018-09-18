# frozen_string_literal: true

class FileImportsController < ApplicationController
  before_action :authenticate_user!

  def create
    store = Store.find(params['store_id'])
    authorize! :read, store

    if ['application/json', 'text/csv'].include?(params['file'].content_type)
      @file = FileImport.new(file_import_params)
      @file.user = current_user

      return render nothing: true, status: :no_content if @file.save
    end
    render nothing: true, status: :unprocessable_entity
  end

  private

  def file_import_params
    params.permit(:file, :store_id)
  end
end
