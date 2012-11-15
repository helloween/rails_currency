require 'uri'
require 'open-uri'
require 'timeout'

begin
  require 'hpricot'
rescue LoadError
  require 'rubygems'
  require 'hpricot'
end

module RailsCurrency
  class RailsCurrencyError < StandardError
  end

  class InvalidAmountError < RailsCurrencyError
  end

  class UnknownCurrencyError < RailsCurrencyError
  end

  class ServerTimeoutError < RailsCurrencyError
  end

  class Convertor
    class << self
      def convert(amount, from, to)
        raise InvalidAmountError, "Only numeric value allowed" unless amount.is_a?(Numeric)
        raise UnknownCurrencyError, "Unknown Currency" unless CurrencyList.key?(from.to_sym) && CurrencyList.key?(to.to_sym)

        begin
          url = "#{CurrencyUrl}?a=#{amount}&from=#{from}&to=#{to}"

          timeout(30) do
            doc = open(url, Params) { |f| Hpricot(f) }
            result = doc.search("//span[@class='bld']").inner_html
            result.split(' ').first.to_f
          end
        rescue TimeoutError
          raise ServerTimeoutError, "Can't connect to server #{url}"
        end
      end
    end
  end
end
