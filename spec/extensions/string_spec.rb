require 'rails_helper'

RSpec.describe String do
  it :to_slug do
    expect('AZER azer'.to_slug).to eq('azer-azer')
  end
end
