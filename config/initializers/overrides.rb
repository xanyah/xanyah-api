# frozen_string_literal: true

Rails.root.glob('lib/extensions/*.rb').each { |l| require l }
