# frozen_string_literal: true

require 'thor'

require_relative 'version'
require_relative 'rates_converter'

module Rates
  # Command line interface for rates
  class CLI < Thor
    default_task :help
  
    map %w[--version -v] => :version
    desc '--version, -v', 'Print the version.'
    def version
      puts "Rates #{VERSION}"
    end

    map %w[--convert -c] => :convert
    method_option :amount, type: :numeric, required: true
    method_option :source, type: :string, required: true
    method_option :target, type: :string, required: true
    desc '--convert, -c', 'Convert the given amount from source currency to target currency.'
    def convert
      converter = RatesConverter.new
      source_currency = options['source']
      target_currency = options['target']
      source_value = options['amount']

      begin
        target_value = converter.convert(source_value, source_currency, target_currency)
        puts "#{source_value} #{source_currency} => #{target_value} #{target_currency}"
      rescue ArgumentError => e
        puts e.message
      end
    end

    map %w[--supported -s] => :supported_currencies
    desc '--supported, -s', 'List supported currencies.'
    def supported_currencies
      converter = RatesConverter.new
      puts converter.supported_currencies.join(', ')
    end
  end
end
