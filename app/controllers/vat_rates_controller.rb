# frozen_string_literal: true

class VatRatesController < ApplicationController
  # GET /vat_rates
  def index
    render json: JSONVAT.rates
  end

  # GET /vat_rates/1
  def show
    render json: JSONVAT.country(params[:id])
  end
end
