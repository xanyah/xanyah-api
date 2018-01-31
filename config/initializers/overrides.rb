# frozen_string_literal: true

Dir[Rails.root.join('lib', 'extensions', '*.rb')].each {|l| require l }
