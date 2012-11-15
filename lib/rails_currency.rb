require File.dirname(__FILE__) + "/rails_currency/convertor"
require File.dirname(__FILE__) + "/rails_currency/constants"

RailsCurrency::Convertor.class_eval do
  extend RailsCurrency::Constants
end
