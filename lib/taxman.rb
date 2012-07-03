require "rubygems"
require "bundler/setup"

class Taxman
	class <<self
		def tax(income)
			raise ArgumentError.new("income must be numeric") unless (Float(income) rescue false)
			raise ArgumentError.new("income must be positive") if income < 0

			tax = if income < 18201
				0
			elsif income < 37001
				(income - 18200) * 0.19
			elsif income < 80001
				3572 + (income - 37000) * 0.325
			elsif income < 180001
				17547 + (income - 80000) * 0.37
			else
				54547 + (income - 180000) * 0.45
			end

			tax += income.to_f * 0.015 if tax > 0

			tax.to_f.round(3)
		end

		def parse(client)
			name, income = client.split(',')

			raise Exception.new("missing data") if name.nil? || income.nil?

			name.strip!
			income.strip!

			raise ArgumentError.new("income must be numeric") unless (Float(income) rescue false)
			income = income.to_f
			raise ArgumentError.new("income must be positive") if income < 0

			[name, income]
		end

		def process(client)
			name, income = parse(client)

			tax = tax(income)
			left = income - tax

			"#{name}, #{tax.round(0)}, #{left.round(0)}"
		end
	end
end
