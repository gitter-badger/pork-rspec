
require 'pork-rspec/expect'

module RSpec
  module Context
    def described_class klass=self.class
      case desc = klass.desc
      when NilClass, String
        if parent = klass.instance_variable_get(:@super_executor)
          described_class(parent)
        end
      else
        desc
      end
    end

    def subject
      @subject ||= case klass = described_class
                   when Class
                     klass.new
                   else
                     klass
                   end
    end

    def is_expected
      expect(subject)
    end

    def expect obj
      Expect.new(pork_stat, obj)
    end

    def eq rhs
      ->(expect){ expect == rhs }
    end

    def eql rhs
      ->(expect){ expect.eql?(rhs) }
    end

    def equal rhs
      ->(expect){ expect.equal?(rhs) }
    end
    alias_method :be, :equal

    def be_an_instance_of rhs
      ->(expect){ expect.class == rhs }
    end

    def be_a rhs
      ->(expect){ expect.kind_of?(rhs) }
    end
    alias_method :be_an, :be_a
    alias_method :be_a_kind_of, :be_a

    def be_truthy
      ->(expect){ expect != nil && expect != false }
    end

    def be_falsey
      ->(expect){ !expect }
    end

    def be_empty
      :empty?.to_proc
    end

    def be_nil
      eq(nil)
    end

    def contain_exactly *elements
      eq(elements)
    end

    def start_with str
      ->(expect){ expect.start_with?(str) }
    end
  end
end
