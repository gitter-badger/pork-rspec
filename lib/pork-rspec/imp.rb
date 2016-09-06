
require 'pork'
require 'pork-rspec/alias'

module RSpec
  module Imp
    include Pork::Imp
    include Alias

    def let name, &block
      define_method(name) do
        ivar = "@#{name}"
        instance_variable_get(ivar) ||
          instance_variable_set(ivar, instance_eval(&block))
      end
    end
    alias_method :given, :let

    def let! name, &block
      let(name, &block)
      before{ __send__(name) }
    end

    def subject &block
      let(:subject, &block)
    end
  end
end