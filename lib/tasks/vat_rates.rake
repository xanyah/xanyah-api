# frozen_string_literal: true

require 'net/http'

namespace :vat_rates do
  desc 'Update VAT rates from https://euvat.ga/'
  task update: :environment do
    ActiveRecord::Migration.check_pending!
    response = Net::HTTP.get(URI("http://apilayer.net/api/rate_list?access_key=#{ENV['VAT_LAYER_API_KEY']}"))
    response = JSON.parse(response)
    rates = response['rates']
    rates.each_key do |country_code|
      api_rate = rates[country_code]
      vat_rate = VatRate.where(country_code: country_code).first_or_create
      vat_rate.update(
        country_name:  api_rate['country'] || 0,
        standard_rate: api_rate['standard_rate'] || 0
        # reduced_rate:       api_rate['reduced_rate'] || 0,
        # reduced_rate_alt:   api_rate['reduced_rate_alt'] || 0,
        # super_reduced_rate: api_rate['super_reduced_rate'] || 0,
        # parking_rate:       api_rate['parking_rate'] || 0
      )
    end
  end
end
