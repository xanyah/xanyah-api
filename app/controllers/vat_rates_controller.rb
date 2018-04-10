# frozen_string_literal: true

class VatRatesController < ApplicationController
  before_action :set_vat_rate, only: :show

  # GET /vat_rates
  def index
    @vat_rates = VatRate.all

    render json: @vat_rates
  end

  # GET /vat_rates/1
  def show
    render json: @vat_rate
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vat_rate
    @vat_rate = VatRate.find_by(country_code: params[:id])
  end
end
